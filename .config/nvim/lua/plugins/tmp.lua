return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = 'ollama',
      auto_suggestions_provider = 'ollama_suggest',
      vendors = {
        ollama_suggest = {
          api_key_name = 'bc2bef2f3fd5062fe2932722d50083f6',
          endpoint = 'media:5010/v1',
          model = 'lucyknada_Qwen_Qwen2.5-Coder-1.5B-Instruct-exl2',
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint .. '/chat/completions',
              headers = {
                ['Accept'] = 'application/json',
                ['Content-Type'] = 'application/json',
                ['x-api-key'] = 'bc2bef2f3fd5062fe2932722d50083f6',
              },
              body = {
                model = opts.model,
                messages = require('avante.providers').copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
                max_tokens = 8192,
                stream = true,
              },
            }
          end,
          parse_response_data = function(data_stream, event_state, opts)
            require('avante.providers').openai.parse_response(data_stream, event_state, opts)
          end,
        },
        ollama = {
          api_key_name = 'bc2bef2f3fd5062fe2932722d50083f6',
          endpoint = 'media:5010/v1',
          model = 'bartowski_Qwen2.5-Coder-32B-Instruct-exl2',
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint .. '/chat/completions',
              headers = {
                ['Accept'] = 'application/json',
                ['Content-Type'] = 'application/json',
                ['x-api-key'] = 'bc2bef2f3fd5062fe2932722d50083f6',
              },
              body = {
                model = opts.model,
                messages = require('avante.providers').copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
                max_tokens = 8192,
                stream = true,
              },
            }
          end,
          parse_response_data = function(data_stream, event_state, opts)
            require('avante.providers').openai.parse_response(data_stream, event_state, opts)
          end,
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
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
          },
        },
      },
      -- {
      --   -- Make sure to set this up properly if you have lazy=true
      --   'MeanderingProgrammer/render-markdown.nvim',
      --   opts = {
      --     file_types = { 'markdown', 'Avante' },
      --   },
      --   ft = { 'markdown', 'Avante' },
      -- },
    },
  },

  -- {
  --   'meeehdi-dev/bropilot.nvim',
  --   event = 'VeryLazy', -- preload model on start
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'j-hui/fidget.nvim',
  --   },
  --   opts = {
  --     auto_suggest = false,
  --     excluded_filetypes = { 'something', 'codecompanion', 'gitcommit' },
  --     -- model = 'qwen2.5-coder-7b-base',
  --     model = 'Handgun1773_Qwen2.5-Coder-7B-BASE-8.0bpw-exl2',
  --     model_params = {
  --       num_predict = -2,
  --       top_p = 0.95,
  --       stop = { '<|fim_pad|>', '<|endoftext|>' },
  --     },
  --     -- model_params = {
  --     --   mirostat = 0,
  --     --   mirostat_eta = 0.1,
  --     --   mirostat_tau = 5.0,
  --     --   num_ctx = 2048,
  --     --   repeat_last_n = 64,
  --     --   repeat_penalty = 1.1,
  --     --   temperature = 0.8,
  --     --   seed = 0,
  --     --   stop = {},
  --     --   tfs_z = 1,
  --     --   num_predict = 128,
  --     --   top_k = 40,
  --     --   top_p = 0.9,
  --     --   min_p = 0.0,
  --     -- },
  --     prompt = {
  --       prefix = '<|fim_prefix|>',
  --       suffix = '<|fim_suffix|>',
  --       middle = '<|fim_middle|>',
  --     },
  --     debounce = 500, -- careful with this setting when auto_suggest is enabled, can lead to curl jobs overload
  --     keymap = {
  --       accept_word = '<C-Right>',
  --       accept_line = '<S-Right>',
  --       accept_block = '<C-Up>',
  --       suggest = '<C-Down>',
  --     },
  --     ollama_url = 'http://media:5010/v1',
  --   },
  --   config = function(_, opts)
  --     require('bropilot').setup(opts)
  --   end,
  -- },
  {
    'chrisgrieser/nvim-lsp-endhints',
    event = 'LspAttach',
    opts = {}, -- required, even if empty
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    config = function()
      require('tiny-inline-diagnostic').setup()
    end,
  },
  {
    'jiaoshijie/undotree',
    dependencies = { { 'nvim-lua/plenary.nvim', branch = 'master' } },
    config = function()
      local undotree = require 'undotree'

      undotree.setup {
        float_diff = false, -- using float window previews diff, set this `true` will disable layout option
        layout = 'left_bottom', -- "left_bottom", "left_left_bottom"
        position = 'left', -- "right", "bottom"
        ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
        window = {
          winblend = 30,
        },
        keymaps = {
          ['<down>'] = 'move_next',
          ['<up>'] = 'move_prev',
          ['g<down>'] = 'move2parent',
          ['<S-down>'] = 'move_change_next',
          ['<S-up>'] = 'move_change_prev',
          ['<cr>'] = 'action_enter',
          ['i'] = 'enter_diffbuf',
          ['q'] = 'quit',
        },
      }
    end,
    keys = { -- load the plugin only when using it's keybinding:
      { '<leader>uu', "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  {
    'chrisgrieser/nvim-chainsaw',
    keys = {
      { '<leader>lv', '<cmd>lua require("chainsaw").variableLog()<CR>', desc = '[L]og [V]ariable' },
      { '<leader>lt', '<cmd>lua require("chainsaw").typeLog()<CR>', desc = '[L]og [T]ype' },
      { '<leader>la', '<cmd>lua require("chainsaw").assertLog()<CR>', desc = '[L]og [A]ssertion' },
      { '<leader>le', '<cmd>lua require("chainsaw").emojiLog()<CR>', desc = '[L]og [E]moji' },
      { '<leader>lm', '<cmd>lua require("chainsaw").messageLog()<CR>', desc = '[L]og [M]essage' },
      { '<leader>ld', '<cmd>lua require("chainsaw").debugLog()<CR>', desc = '[L]og [D]ebug' },
      { '<leader>lT', '<cmd>lua require("chainsaw").timeLog()<CR>', desc = '[L]og [T]ime' },
      { '<leader>ls', '<cmd>lua require("chainsaw").stacktraceLog()<CR>', desc = '[L]og [S]tacktrace' },
      { '<leader>lr', '<cmd>lua require("chainsaw").removeLogs()<CR>', desc = '[R]emove [L]ogs' },
    },
    opts = {
      logStatements = {
        variableLog = {
          typescriptreact = 'console.log("%s %s:", %s);',
        },
        objectLog = {
          typescriptreact = 'console.log("%s %s:", JSON.stringify(%s))',
        },
        assertLog = {
          typescriptreact = 'console.assert(%s, "%s %s");',
        },
        typeLog = {
          typescriptreact = 'console.log("%s %s: type is " + typeof %s)',
        },
        emojiLog = {
          typescriptreact = 'console.log("%s %s");',
        },
        sound = { -- NOTE terminal bell commands requires program to run in a terminal supporting it
          typescriptreact = 'new Audio("data:audio/wav;base64,UklGRl9vT19XQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YU"+Array(800).join("200")).play()',
        },
        messageLog = {
          typescriptreact = 'console.log("%s ");',
        },
        stacktraceLog = {
          typescriptreact = 'console.trace("%s stacktrace: ");',
        },
        debugLog = {
          typescriptreact = 'debugger; // %s',
        },
        clearLog = {
          typescriptreact = 'console.clear(); // %s',
        },
        timeLogStart = {
          javascriptreact = 'const timelogStart%s = Date.now(); // %s', -- not all JS engines support console.time
          typescriptreact = 'console.time("#%s %s");', -- string needs to be identical to `console.timeEnd`
        },
        timeLogStop = {
          javascriptreact = 'console.log(`#%s %s: ${(Date.now() - timelogStart%s) / 1000}s`);',
          typescriptreact = 'console.timeEnd("#%s %s");',
        },
      },
    },
  },
  -- {
  --   'jackMort/tide.nvim',
  --   config = function()
  --     require('tide').setup {
  --       -- optional configuration
  --     }
  --   end,
  --   requires = {
  --     'MunifTanjim/nui.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  -- },
  -- {
  --   'chrisgrieser/nvim-scissors',
  --   dependencies = { 'stevearc/dressing.nvim', 'nvim-telescope/telescope.nvim' },
  --   opts = {
  --     snippetDir = vim.fn.stdpath 'config' .. '/snippets',
  --   },
  -- },
}
