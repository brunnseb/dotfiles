return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {
          enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true, -- show stop reason when stopped for exceptions
          commented = false, -- prefix virtual text with comment string
          only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
          all_references = false, -- show virtual text on all all references of the variable (not only definitions)
          filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
          -- Experimental Features:
          virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
          all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
          virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        },
      },
      {
        'rcarriga/nvim-dap-ui',
        keys = {
          {
            '<s-e>',
            function()
              require('dapui').eval()
            end,
          },
          {
            '<leader>df',
            function()
              require('dapui').float_element()
            end,
            desc = 'Float element',
          },
          {
            '<leader>dw',
            function()
              require('dapui').float_element 'watches'
              require('dapui').float_element 'watches'
            end,
            desc = 'Watches',
          },
        },
      },
    },
    keys = {
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Breakpoint',
      },
      {
        '<leader>dC',
        function()
          local condition = vim.fn.input {
            prompt = 'Condition: ',
            -- completion = 'file',
          }
          require('dap').set_breakpoint(condition)
        end,
        desc = 'Conditional Breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>dB',
        function()
          require('dap').step_back()
        end,
        desc = 'Step back',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step into',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_out()
        end,
        desc = 'Step out',
      },
      {
        '<leader>do',
        function()
          require('dap').step_over()
        end,
        desc = 'Step over',
      },
      {
        '<leader>dr',
        function()
          require('dap').restart()
        end,
        desc = 'Restart',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
    },
    config = function()
      local dap = require 'dap'

      dap.adapters['pwa-chrome'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            '/home/brunnseb/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }
      for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'svelte' } do
        dap.configurations[language] = {
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Launch Chrome with "localhost"',
            url = function()
              local port = vim.fn.input {
                prompt = 'Port (default 3000): ',
                completion = 'file',
              }
              if port == nil or port == '' then
                return 'http://localhost:3000'
              else
                return 'http://localhost:'
              end
            end,
            webRoot = '${workspaceFolder}',
            runtimeExecutable = '/usr/bin/chromium',
            runtimeArgs = { '--remote-debugging-port=9222' },
            sourceMaps = true,
            skipFiles = {
              '<node_internals>/**/*.js',
              '**/node_modules/**',
            },
          },
        }
      end

      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '⭐️', texthl = '', linehl = '', numhl = '' })

      local dapui = require 'dapui'
      dapui.setup {
        controls = {
          element = 'repl',
          enabled = false,
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
          border = 'single',
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        force_buffers = true,
        icons = {
          collapsed = '',
          current_frame = '',
          expanded = '',
        },
        layouts = {
          {
            elements = {
              {
                id = 'scopes',
                size = 0.60,
              },
              {
                id = 'breakpoints',
                size = 0.4,
              },
            },
            position = 'left',
            size = 30,
          },
          {
            elements = {
              {
                id = 'watches',
                size = 0.5,
              },
              {
                id = 'repl',
                size = 0.5,
              },
            },
            position = 'bottom',
            size = 7,
          },
        },
        mappings = {
          edit = 'e',
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          repl = 'r',
          toggle = 't',
        },
        render = {
          indent = 1,
          max_value_lines = 100,
        },
      }

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open { reset = true }
      end
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
}
