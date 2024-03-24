return {
  {
    'tzachar/highlight-undo.nvim',
    opts = {},
  },

  -- Custom Parameters (with defaults)
  {
    'David-Kunz/gen.nvim',
    opts = {
      model = 'pxlksr/opencodeinterpreter-ds', -- The default model to use.
      host = 'localhost', -- The host running the Ollama service.
      port = '11434', -- The port on which the Ollama service is listening.
      quit_map = 'q', -- set keymap for close the response window
      retry_map = '<c-r>', -- set keymap to re-send the current prompt
      init = function(options)
        pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
      end,
      -- Function to initialize Ollama
      command = function(options)
        local body = { model = options.model, stream = true }
        return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      display_mode = 'float', -- The display mode. Can be "float" or "split".
      show_prompt = false, -- Shows the prompt submitted to Ollama.
      show_model = false, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      debug = false, -- Prints errors and the command which is run.
    },
    config = function(_, opts)
      require('gen').setup(opts)
      require('gen').prompts['Doc'] = {
        'Write a docstring in $filetype' .. '" in format: ```$filetype\n...\n``` without any other text.',
        replace = false,
        extract = '```$filetype\n(.-)```',
      }
    end,
  },
  {
    'nomnivore/ollama.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    -- All the user commands added by the plugin
    cmd = { 'Ollama', 'OllamaModel', 'OllamaServe', 'OllamaServeStop' },

    keys = {
      {
        '<leader>oo',
        ":<c-u>lua require('ollama').prompt()<cr>",
        desc = 'ollama prompt',
        mode = { 'n', 'v' },
      },

      -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
      {
        '<leader>oG',
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        desc = 'ollama Generate Code',
        mode = { 'n', 'v' },
      },
    },

    ---@type Ollama.Config
    opts = {
      model = 'deepseek-coder:6.7b',
      prompts = {
        Sample_Prompt = {
          -- model = 'deepseek-coder:6.7b',
          model = 'pxlksr/opencodeinterpreter-ds',
          prompt = 'You are an expert programmer that writes simple, concise code and explanations. Write a docstring for the following function: $sel in the $ftype progamming language',
          -- prompt = 'Generate $ftype docstring for the following code $sel without any explanation. Make sure to not include any $ftype code in your response except for the generated docstring.',
          action = {
            fn = function(prompt)
              local opts = {
                display = true,
                insert = true,
                replace = false,
                show_prompt = false,
                window = 'float',
              }
              local tokens = {}

              -- stuff for display
              local out_buf
              local out_win
              local timer
              local pre_lines

              -- stuff for insert
              local bufnr
              local cursorLine
              if opts.insert then
                bufnr = vim.fn.bufnr '%' or 0
                cursorLine = vim.fn.line '.' or 1
              end

              -- stuff for replace
              local sel_pos
              if opts.replace then
                bufnr = vim.fn.bufnr '%' or 0
                sel_pos = require('ollama.util').get_selection_pos()
                if sel_pos == nil then
                  vim.api.nvim_notify('No selection found', vim.log.levels.INFO, { title = 'Ollama' })
                  return false
                end
              end

              ---@type Job?
              local job
              local is_cancelled = false

              if opts.display then
                out_buf = vim.api.nvim_create_buf(false, true)
                local input_label = prompt.input_label or '> '
                local display_prompt = input_label .. ' ' .. prompt.parsed_prompt .. '\n\n'
                pre_lines = vim.split(display_prompt, '\n')
                vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, pre_lines)

                if opts.window == 'float' then
                  out_win = require('ollama.util').open_floating_win(out_buf, { title = prompt.model })
                elseif opts.window == 'split' then
                  vim.cmd 'split'
                  out_win = vim.api.nvim_get_current_win()
                  require('ollama.util').set_output_options(out_buf, out_win)
                  vim.api.nvim_win_set_buf(out_win, out_buf)
                elseif opts.window == 'vsplit' then
                  vim.cmd 'vsplit'
                  out_win = vim.api.nvim_get_current_win()
                  require('ollama.util').set_output_options(out_buf, out_win)
                  vim.api.nvim_win_set_buf(out_win, out_buf)
                end

                timer = require('ollama.util').show_spinner(out_buf, { start_ln = #pre_lines, end_ln = #pre_lines + 1 }) -- the +1 makes sure the old spinner is replaced

                -- empty lines as padding so that the response lands in the right place
                vim.api.nvim_buf_set_lines(out_buf, -1, -1, false, { '', '' })

                -- set some keybinds for the buffer
                vim.api.nvim_buf_set_keymap(out_buf, 'n', 'q', '<cmd>q<cr>', { noremap = true })

                vim.api.nvim_buf_attach(out_buf, false, {
                  on_detach = function()
                    if job ~= nil then
                      is_cancelled = true
                      job:shutdown()
                    end
                  end,
                })
              end
              ---@type Ollama.PromptActionResponseCallback
              return function(body, _job)
                if job == nil and _job ~= nil then
                  job = _job
                  if is_cancelled and timer then
                    timer:stop()
                    job:shutdown()
                  end
                end
                table.insert(tokens, body.response)
                local lines = vim.split(table.concat(tokens), '\n')

                if opts.display then
                  vim.api.nvim_buf_set_lines(out_buf, #pre_lines + 2, -1, false, lines)
                end

                if body.done then
                  if timer then
                    timer:stop()
                  end

                  if opts.display then
                    vim.api.nvim_buf_set_lines(out_buf, #pre_lines, #pre_lines + 1, false, {
                      ('> %s in %ss.'):format(prompt.model, require('ollama.util').nano_to_seconds(body.total_duration)),
                    })
                    vim.api.nvim_set_option_value('modifiable', false, { buf = out_buf })
                  end

                  if opts.insert or opts.replace then
                    local text = table.concat(lines, '\n')
                    if prompt.extract then
                      local extract = prompt.extract

                      if string.find(text, '```jsx') then
                        extract = '```jsx\n(.-)```'
                      elseif string.find(text, '```tsx') then
                        extract = '```tsx\n(.-)```'
                      elseif string.find(text, '```typescript') then
                        extract = '```typescript\n(.-)```'
                      end
                      text = text:match(extract)
                    end

                    if text == nil then
                      vim.api.nvim_notify('No match found', vim.log.levels.INFO, { title = 'Ollama' })
                      return
                    end

                    lines = vim.split(text, '\n')

                    if opts.replace then
                      local start_line, start_col, end_line, end_col = unpack(sel_pos)
                      vim.api.nvim_buf_set_text(bufnr, start_line, start_col, end_line, end_col, lines)
                    elseif opts.insert then
                      vim.api.nvim_buf_set_lines(bufnr, cursorLine - 1, cursorLine - 1, false, lines)
                    end

                    -- close floating window when done insert/replacing
                    if out_win and vim.api.nvim_win_is_valid(out_win) then
                      vim.api.nvim_win_close(out_win, true)
                    end
                  end
                end
              end
            end,
          },
        },
      },
    },
  },
}
