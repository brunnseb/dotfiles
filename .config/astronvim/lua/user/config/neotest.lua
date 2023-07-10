local M = {}

M.setup = function()
  require("neotest").setup {
    adapters = {
      require "neotest-vitest",
    },
  }
end

return M
