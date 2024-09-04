return {
  { 'joshuavial/aider.nvim', config = true },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
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
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   version = false,
  --   build = 'make',
  --     behaviour = {
  --       auto_apply_diff_after_generation = true,
  --     },
  --     vendors = {
  --       ---@type AvanteProvider
  --       deepseek = {
  --         endpoint = 'https://api.deepseek.com/chat/completions',
  --         model = 'deepseek-coder',
  --         api_key_name = 'DEEPSEEK_API_KEY',
  --         parse_curl_args = function(opts, code_opts)
  --           return {
  --             url = opts.endpoint,
  --             headers = {
  --               ['Accept'] = 'application/json',
  --               ['Content-Type'] = 'application/json',
  --               ['Authorization'] = 'Bearer ' .. os.getenv(opts.api_key_name),
  --             },
  --             body = {
  --               model = opts.model,
  --               messages = require('avante.providers').copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
  --               temperature = 0,
  --               max_tokens = 4096,
  --               stream = true, -- this will be set by default.
  --             },
  --           }
  --         end,
  --         parse_response_data = function(data_stream, event_state, opts)
  --           require('avante.providers').copilot.parse_response(data_stream, event_state, opts)
  --         end,
  --       },
  --     },
  --   },
  --   dependencies = {
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     --- The below dependencies are optional,
  --     'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
  --     'zbirenbaum/copilot.lua', -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       'HakonHarnes/img-clip.nvim',
  --       event = 'VeryLazy',
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to setup it properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { 'markdown', 'Avante' },
  --       },
  --       ft = { 'markdown', 'Avante' },
  --     },
  --   },
  -- },
}
