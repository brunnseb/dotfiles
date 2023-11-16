return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      return {
        adapters = {
          require("neotest-vitest"),
        },
      }
    end,
  },
}
