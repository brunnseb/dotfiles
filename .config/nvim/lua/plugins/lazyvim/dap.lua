return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      require("dap").adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.expand("$HOME/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
      for _, lang in ipairs({
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
      }) do
        dap.configurations[lang] = {
          {
            -- use nvim-dap-vscode-js's pwa-chrome debug adapter
            type = "pwa-chrome",
            request = "launch",
            -- name of the debug action
            name = "Launch Chrome to debug client side code",
            -- default vite dev server url
            url = "http://localhost:3000",
            sourceMaps = true,
            webRoot = "${workspaceFolder}",
            -- protocol = "inspector",
            -- port = 9222,
            runtimeExecutable = "/usr/bin/brave",
            runtimeArgs = { "--remote-debugging-port=9222" },
            -- skip files from vite's hmr
            skipFiles = { "<node_internals>/**/*.js", "**/node_modules/**/*", "**/@vite/*" },
            -- resolveSourceMapLocations = {
            --   "${workspaceFolder}/**",
            --   "!**/node_modules/**",
            -- },

            -- From https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/plugins/dap.lua
            -- To test how it behaves
            -- rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            -- sourceMapPathOverrides = {
            --   ["./*"] = "${workspaceFolder}/src/*",
            -- },
          },
        }
      end
    end,
  },
}
