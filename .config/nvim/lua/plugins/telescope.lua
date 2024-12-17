local ts_select_dir_for_grep = function(prompt_bufnr)
  local action_state = require 'telescope.actions.state'
  local fb = require('telescope').extensions.file_browser
  local live_grep = require('telescope.builtin').live_grep
  local current_line = action_state.get_current_line()

  fb.file_browser {
    attach_mappings = function(prompt_bufnr)
      require('telescope.actions').select_horizontal:replace(function()
        local entry_path = action_state.get_selected_entry().Path
        local dir = entry_path:is_dir() and entry_path or entry_path:parent()
        local relative = dir:make_relative(vim.fn.getcwd())
        local absolute = dir:absolute()

        live_grep {
          results_title = relative .. '/',
          cwd = absolute,
          default_text = current_line,
        }
      end)

      return true
    end,
  }
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
    },

    config = function()
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch [G]rep' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>sj', builtin.jumplist, { desc = '[S]earch [J]umplist' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      require('telescope').setup {
        defaults = {
          path_display = { 'smart' },
        },
        pickers = {
          find_files = {
            on_complete = {
              function()
                vim.schedule(function()
                  local action_state = require 'telescope.actions.state'
                  local prompt_bufnr = require('telescope.state').get_existing_prompt_bufnrs()[1]

                  local picker = action_state.get_current_picker(prompt_bufnr)
                  if picker == nil then
                    return
                  end
                  local results = picker.layout.results
                  local bufnr = results.bufnr
                  local count = vim.api.nvim_buf_line_count(bufnr)
                  if count == 1 and vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)[1] == '' then
                    local line = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, -1, false)[1]
                    local new_line = line:gsub("'", ' ')
                    vim.api.nvim_buf_set_lines(prompt_bufnr, 0, -1, false, { new_line })
                  end
                end)
              end,
            },
            default_text = "'",
          },
          live_grep = {
            mappings = {
              i = {
                ['<C-f>'] = ts_select_dir_for_grep,
              },
              n = {
                ['<C-f>'] = ts_select_dir_for_grep,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          },
          file_browser = {
            theme = 'ivy',
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ['i'] = {
                -- your custom insert mode mappings
              },
              ['n'] = {
                -- your custom normal mode mappings
              },
            },
          },
        },
      }

      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'file_browser'
    end,
  },
}
