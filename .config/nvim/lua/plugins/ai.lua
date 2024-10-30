return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    opts = {
      system_prompt = [[
       You are an expert in TypeScript, Node.js, React Router v6, React, Shadcn UI, Radix UI, and Tailwind.
       Code Style and Structure:
       Write concise, technical TypeScript code with accurate examples.
       Use functional and declarative programming patterns; avoid classes.
       Prefer iteration and modularization over code duplication.
       Use descriptive variable names with auxiliary verbs (e.g., isLoading, hasError).
       Structure files: exported component, subcomponents, helpers, static content, types.
       Naming Conventions
       Use lowercase with dashes for directories (e.g., components/auth-wizard).
       Favor named exports for components.
       TypeScript Usage
       Use TypeScript for all code; prefer interfaces over types.
       Avoid enums when few options; use union string type instead
       Use functional components with TypeScript interfaces (const preferred)
       Syntax and Formatting
       Use the "function" keyword for pure functions.
       Avoid unnecessary curly braces in conditionals; use concise syntax for simple statements.
       Use declarative TSX.
       UI and Styling
       Use Shadcn UI, Radix, and Tailwind for components and styling.
       Implement responsive design with Tailwind CSS.
       Performance Optimization
       Minimize 'useEffect', and 'setState'.
      ]],
      provider = 'ollama',
      auto_suggestions_provider = 'codestral_suggest',
      behaviour = {
        -- auto_suggestions = true,
        -- auto_set_keymaps = false,
        -- auto_apply_diff_after_generation = true,
      },
      mappings = {
        suggestion = {
          accept = '<A-e>',
          next = '<A-o>',
          prev = '<A-i>',
          dismiss = '<A-.>',
        },
      },
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-3-haiku-20240307',
        temperature = 0,
        max_tokens = 4096,
      },
      vendors = {
        ollama_suggest_test = {
          ['local'] = true,
          endpoint = 'media:7869/api/generate',
          model = 'starcoder2:3b',
          -- model = 'qwen2.5-coder:7b-instruct-q3_K_S',
          parse_curl_args = function(opts, code_opts)
            local startIdx = string.find(code_opts.user_prompts[1], 'L1')
            local endIdx = string.find(code_opts.user_prompts[1], '```', startIdx)
            local questionIdx = string.find(code_opts.user_prompts[2], 'QUESTION:')
            if questionIdx and startIdx and endIdx then
              local code = string.sub(code_opts.user_prompts[1], startIdx, endIdx - 1)
              local question = string.sub(code_opts.user_prompts[2], questionIdx + 9)
              local questionTable = vim.fn.json_decode(question)
              local promptIdx = string.find(code, 'L' .. questionTable.position.row) + questionTable.position.col
              if promptIdx then
                local prompt = string.sub(code, 1, promptIdx)
                local suffix = string.sub(code, promptIdx)
                local body = {
                  model = opts.model,
                  prompt = prompt,
                  suffix = suffix,
                  -- messages = require('avante.providers').copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
                  max_tokens = 8192,
                  temperature = 0,
                  stream = true,
                }
                print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:149 -> body: ' .. vim.inspect(body))
                return {
                  url = opts.endpoint,
                  headers = {
                    ['Accept'] = 'application/json',
                    ['Content-Type'] = 'application/json',
                  },
                  body = body,
                }
              end
            end
            -- TODO: look at https://github.com/ollama/ollama/pull/5207 for suggestions
          end,
          parse_response_data = function(data_stream, event_state, opts)
            print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:162 -> event_state: ' .. vim.inspect(event_state))
            print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:162 -> data_stream: ' .. vim.inspect(data_stream))
            require('avante.providers').openai.parse_response(data_stream, event_state, opts)
          end,
        },
        codestral_suggest = {
          endpoint = 'https://codestral.mistral.ai/v1/fim/completions',
          model = 'codestral-latest',
          api_key_name = 'MISTRAL_API_KEY',
          parse_curl_args = function(opts, code_opts)
            local startIdx = string.find(code_opts.user_prompts[1], 'L1')
            local endIdx = string.find(code_opts.user_prompts[1], '```', startIdx)
            local trim = function(content)
              return vim
                .iter(vim.split(content, '\n'))
                :map(function(line)
                  local new_line = line:gsub('^L%d+: ', '')
                  return new_line
                end)
                :join '\n'
            end
            local questionIdx = string.find(code_opts.user_prompts[2], 'QUESTION:')
            if questionIdx and startIdx and endIdx then
              local code = string.sub(code_opts.user_prompts[1], startIdx, endIdx - 1)
              local question = string.sub(code_opts.user_prompts[2], questionIdx + 9)
              local questionTable = vim.fn.json_decode(question)
              local promptIdx = string.find(code, 'L' .. questionTable.position.row) + questionTable.position.col + 5
              if promptIdx then
                local prompt = string.sub(code, 1, promptIdx)
                local suffix = string.sub(code, promptIdx)
                local body = {
                  model = opts.model,
                  prompt = trim(prompt),
                  suffix = trim(suffix),
                  -- messages = require('avante.providers').copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
                  max_tokens = 8192,
                  temperature = 0,
                  top_p = 1,
                  stream = false,
                }
                print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:149 -> body: ' .. vim.inspect(body))
                return {
                  url = opts.endpoint,
                  headers = {
                    ['Accept'] = 'application/json',
                    ['Content-Type'] = 'application/json',
                    ['Authorization'] = 'Bearer ' .. os.getenv(opts.api_key_name),
                  },
                  body = body,
                }
              end
            end
          end,
          parse_response_without_stream = function(data_stream, event_state, opts)
            print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:197 -> opts: ' .. vim.inspect(opts))
            print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:197 -> event_state: ' .. vim.inspect(event_state))
            print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:197 -> data_stream: ' .. vim.inspect(data_stream))
            local obj = data_stream
            require('avante.providers').copilot.parse_response(data_stream, event_state, opts)
          end,
          -- parse_response_data = function(data_stream, event_state, opts)
          --   print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:197 -> opts: ' .. vim.inspect(opts))
          --   print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:197 -> event_state: ' .. vim.inspect(event_state))
          --   print('[LS] -> /home/brunnseb/.config/nvim/lua/plugins/tmp.lua:197 -> data_stream: ' .. vim.inspect(data_stream))
          --   require('avante.providers').copilot.parse_response(data_stream, event_state, opts)
          -- end,
        },
        ollama_suggest = {
          ['local'] = true,
          endpoint = 'media:7869/v1',
          model = 'starcoder2:3b',
          -- model = 'deepseek-coder-v2:16b-lite-instruct-q5_0',
          -- model = 'llama3.1:8b-instruct-q8_0',
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint .. '/chat/completions',
              headers = {
                ['Accept'] = 'application/json',
                ['Content-Type'] = 'application/json',
              },
              body = {
                model = opts.model,
                messages = require('avante.providers').copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
                max_tokens = 4096,
                temperature = 0,
                stream = false,
              },
            }
          end,
          parse_response_data = function(data_stream, event_state, opts)
            require('avante.providers').openai.parse_response(data_stream, event_state, opts)
          end,
        },
        ollama = {
          ['local'] = true,
          endpoint = 'media:7869/v1',
          model = 'qwen2.5:14b-instruct-q5_0',
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint .. '/chat/completions',
              headers = {
                ['Accept'] = 'application/json',
                ['Content-Type'] = 'application/json',
              },
              body = {
                model = opts.model,
                messages = require('avante.providers').copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
                max_tokens = 8192,
                temperature = 0.1,
                stream = true,
              },
            }
          end,
          parse_response_data = function(data_stream, event_state, opts)
            require('avante.providers').openai.parse_response(data_stream, event_state, opts)
          end,
        },
        ---@type AvanteProvider
        deepseek = {
          endpoint = 'https://api.deepseek.com/chat/completions',
          model = 'deepseek-coder',
          api_key_name = 'DEEPSEEK_API_KEY',
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint,
              headers = {
                ['Accept'] = 'application/json',
                ['Content-Type'] = 'application/json',
                ['Authorization'] = 'Bearer ' .. os.getenv(opts.api_key_name),
              },
              body = {
                model = opts.model,
                messages = require('avante.providers').copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
                temperature = 0,
                max_tokens = 4096,
                stream = true, -- this will be set by default.
              },
            }
          end,
          parse_response_data = function(data_stream, event_state, opts)
            require('avante.providers').copilot.parse_response(data_stream, event_state, opts)
          end,
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
          log_level = 'debug',
          overrides = {
            buftype = {
              nofile = {
                render_modes = { 'n', 'c', 'i' },
                debounce = 5,
              },
            },
            filetype = {},
          },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
      { 'stevearc/dressing.nvim', opts = {} }, -- Optional: Improves `vim.ui.select`
      { 'echasnovski/mini.diff', version = false },
    },
    config = function()
      require('codecompanion').setup {
        opts = {
          -- log_level = 'DEBUG',
        },
        display = {
          chat = {
            show_settings = true,
          },
          diff = {
            enabled = true,
            provider = 'mini_diff',
          },
        },
        strategies = {
          chat = {
            adapter = 'mistral-nemo',
            keymaps = {
              close = {
                modes = {
                  n = 'q',
                },
                index = 3,
                callback = 'keymaps.close',
                description = 'Close Chat',
              },
              stop = {
                modes = {
                  n = '<C-c>',
                  i = '<C-c>',
                },
                index = 4,
                callback = 'keymaps.stop',
                description = 'Stop Request',
              },
              codeblock = {
                modes = {
                  n = 'gc',
                },
                index = 6,
                callback = 'keymaps.codeblock',
                description = 'Insert Codeblock',
              },
              change_adapter = {
                modes = {
                  n = 'gA',
                },
                index = 11,
                callback = 'keymaps.change_adapter',
                description = 'Change adapter',
              },
              fold_code = {
                modes = {
                  n = 'gf',
                },
                index = 12,
                callback = 'keymaps.fold_code',
                description = 'Fold code',
              },
              debug = {
                modes = {
                  n = 'gd',
                },
                index = 13,
                callback = 'keymaps.debug',
                description = 'View debug info',
              },
            },
          },
          inline = {
            adapter = 'mistral-nemo',
          },
          agent = {
            adapter = 'mistral-nemo',
          },
        },
        adapters = {
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = 'ANTHROPIC_API_KEY',
              },
            })
          end,
          ['mistral-nemo'] = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = {
                model = {
                  default = 'qwen2.5:14b-instruct-q5_0',
                  -- default = 'mistral-nemo:12b-instruct-2407-q6_K',
                  -- default = 'codestral:22b-v0.1-q4_0',
                  -- default = 'deepseek-coder-v2:16b-lite-instruct-q5_0',
                },
                -- temperature = {
                --   default = 0.1,
                -- },
                -- mirostat = {
                --   default = 1,
                -- },
                -- repeat_penalty = {
                --   default = 1,
                -- },
                -- num_ctx = {
                --   default = 12000,
                -- },
              },
              env = {
                url = 'http://media:7869',
              },
              headers = {
                ['Content-Type'] = 'application/json',
              },
              parameters = {
                -- sync = true,
              },
            })
          end,
        },
      }
    end,
  },
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('minuet').setup {
        enabled = false,
        notify = 'verbose',
        provider = 'openai_compatible',
        request_timeout = 20,
        provider_options = {
          openai_compatible = {
            -- model = 'mistral-nemo:12b-instruct-2407-q6_K',
            model = 'qwen2.5:14b-instruct-q5_0',
            end_point = 'http://media:7869/v1/chat/completions',
            api_key = 'OLLAMA_API_KEY',
            name = 'Supermaven',
            stream = true,
            optional = {
              -- temperature = 0.3,
              -- mirostat = 1,
              -- repeat_penalty = 1,
              -- max_tokens = 8192,
              -- stop = { '\n\n' },
            },
          },
          openai_fim_compatible = {
            model = 'deepseek-coder',
            end_point = 'https://api.deepseek.com/beta/completions',
            api_key = 'DEEPSEEK_API_KEY',
            name = 'Supermaven',
            stream = true,
            optional = {
              max_tokens = 256,
              stop = { '\n\n' },
            },
          },
          codestral = {
            name = 'Supermaven',
            model = 'codestral-latest',
            end_point = 'https://codestral.mistral.ai/v1/fim/completions',
            api_key = 'CODESTRAL_API_KEY',
            stream = true,
            optional = {
              max_tokens = 256,
              stop = { '\n\n' },
            },
          },
        },
      }
    end,
  },
  {
    'jondkinney/aider.nvim',
    opts = {
      default_bindings = false,
    },
    keys = {
      -- { '<leader>an', '<cmd>AiderOpen --no-auto-commits --model=deepseek/deepseek-coder <CR>', desc = 'aider open' },
      -- { '<leader>an', '<cmd>AiderOpen --no-auto-commits --model=codestral/codestral-latest<CR>', desc = 'aider open' },
      { '<leader>an', '<cmd>AiderOpen --no-auto-commits --model=ollama/deepseek-coder-v2-instruct<CR>', desc = 'aider open' },
    },
  },
}
