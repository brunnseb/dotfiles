return {
  {
    -- dir = '/home/brunnseb/Development/codecompanion.nvim/',
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
          log_level = 'DEBUG',
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
          },
          inline = {
            adapter = 'mistral-nemo',
          },
          agent = {
            adapter = 'mistral-nemo',
          },
        },
        adapters = {
          ['mistral-nemo'] = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = {
                model = {
                  default = 'mistral-nemo:12b-instruct-2407-q5_0',
                },
                -- temperature = {
                --   default = 0.1,
                -- },
                num_ctx = {
                  default = 4096,
                },
              },
              env = {
                url = 'http://192.168.0.191:7869',
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
        provider_options = {
          openai_compatible = {
            model = 'mistral-nemo:12b-instrunct-2407-q5_0',
            end_point = 'http://192.168.0.191:7869/v1/chat/completions',
            api_key = 'OLLAMA_API_KEY',
            name = 'Supermaven',
            stream = true,
            -- optional = {
            --   temperature = 0,
            --   max_tokens = 256,
            --   stop = { '\n\n' },
            -- },
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
