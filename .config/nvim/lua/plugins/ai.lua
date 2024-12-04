return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/nvim-cmp',
      { 'stevearc/dressing.nvim', opts = {} },
      { 'echasnovski/mini.diff', version = false },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'codecompanion', 'Avante' },
        opts = { render_modes = true, file_types = { 'markdown', 'codecompanion', 'Avante' } },
      },
    },
    config = function()
      require('codecompanion').setup {
        opts = {},
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
            return require('codecompanion.adapters').extend('openai', {
              schema = {
                model = {
                  default = 'bartowski_Qwen2.5-Coder-32B-Instruct-exl2',
                },
                num_ctx = {
                  default = 16384,
                },
              },

              url = 'http://media:5010/v1/chat/completions',
              env = {
                api_key = 'TABBY_API_KEY',
              },
              headers = {
                ['Content-Type'] = 'application/json',
              },
              parameters = {},
            })
          end,
        },
      }
    end,
  },
}
