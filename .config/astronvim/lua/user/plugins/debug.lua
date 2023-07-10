return {
  {
    "nvim-neotest/neotest",
    config = function() require("user.config.neotest").setup() end,
    dependencies = {
      "marilari88/neotest-vitest",
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function() require("user.config.nvim-dap").setup() end,
  },
}
