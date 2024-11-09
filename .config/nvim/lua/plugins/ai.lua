return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
      { 'stevearc/dressing.nvim', opts = {} }, -- Optional: Improves `vim.ui.select`
      { 'echasnovski/mini.diff', version = false },
      { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' }, opts = { render_modes = true } },
    },
    config = function()
      local current_filetype = vim.bo.filetype
      vim.notify('🪚 current_filetype: ' .. tostring(current_filetype))
      require('codecompanion').setup {
        opts = {
          -- log_level = 'DEBUG',
        },
        display = {
          chat = {
            show_settings = true,
            render_headers = false,
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
                  default = 'vanilj/supernova-medius:q4_k_m',
                  -- default = 'qwen2.5:14b-instruct-q5_0',
                  -- default = 'mistral-nemo:12b-instruct-2407-q6_K',
                  -- default = 'codestral:22b-v0.1-q4_0',
                  -- default = 'deepseek-coder-v2:16b-lite-instruct-q4_1',
                },
                temperature = {
                  default = 0.1,
                },
                mirostat = {
                  default = 1,
                },
                repeat_penalty = {
                  default = 1,
                },
                num_ctx = {
                  default = 8192,
                },
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
            -- model = 'qwen2.5:14b-instruct-q5_0',
            model = 'vanilj/supernova-medius:q4_k_m',
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
