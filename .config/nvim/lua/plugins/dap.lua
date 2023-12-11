return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          { "<leader>dE", function() require("dapui").eval(vim.fn.input('Eval: ')) end, desc = "Eval input", mode = { "n" } },
        },
      },
    },
    opts = function(_, opts)
      local dap = require("dap")
      -- local dap_utils = require("dap.utils")

      local adapters = {
        "pwa-node",
        "pwa-chrome",
      }

      for _, adapter in ipairs(adapters) do
        dap.adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Configurations                                           │
      -- ╰──────────────────────────────────────────────────────────╯
      local exts = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
      }

      for _, ext in ipairs(exts) do
        dap.configurations[ext] = {
          {
            type = "pwa-chrome",
            request = "launch",
            name = 'Launch Chrome with "localhost"',
            url = "http://localhost:3000",
            -- webRoot = '${workspaceFolder}/apps/cockpit/src',
            webRoot = "${workspaceFolder}",
            runtimeExecutable = "/usr/bin/brave-browser-beta",
            runtimeArgs = { "--remote-debugging-port=9222" },
            sourceMaps = true,
            skipFiles = {
              "<node_internals>/**/*.js",
              "**/node_modules/**",
            },
          },
          {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach Program (pwa-chrome, select port)",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            port = function()
              return vim.fn.input("Select port: ", 9222)
            end,
            webRoot = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
