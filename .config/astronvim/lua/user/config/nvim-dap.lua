local M = {}

M.setup = function()
  local dap = require "dap"
  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {
      os.getenv "HOME" .. "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js",
    },
  }

  dap.configurations.typescriptreact = {
    {
      name = "Launch 3000",
      type = "chrome",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      runtimeExecutable = "/usr/bin/chromium",
    },
    {
      name = "Launch 3001",
      type = "chrome",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3001",
      webRoot = "${workspaceFolder}",
      runtimeExecutable = "/usr/bin/chromium",
    },
    {
      name = "Launch 3002",
      type = "chrome",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3002",
      webRoot = "${workspaceFolder}",
      runtimeExecutable = "/usr/bin/chromium",
    },
    {
      name = "Chrome attach",
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
      skipFiles = { "node_modules/**/*", "**/*.mjs", "**/*.cjs", "**/*.d.ts" },
    },
  }
end

return M
