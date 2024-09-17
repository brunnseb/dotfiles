return {
  {
    'jondkinney/aider.nvim',
    opts = {
      default_bindings = false,
    },
    keys = {
      { '<leader>an', '<cmd>AiderOpen --no-auto-commits --model=ollama/deepseek-coder-v2:16b-lite-instruct-q5_0<CR>', desc = 'aider open' },
    },
  },
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
      auto_suggestions_provider = 'claude',
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
        ollama = {
          ['local'] = true,
          endpoint = '192.168.0.191:7869/v1',
          model = 'deepseek-coder-v2:16b-lite-instruct-q5_0',
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
                temperature = 1,
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
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}
