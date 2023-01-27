return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "pnpm test -- --passWithNoTests",
            cwd = function()
              print("path " .. vim.fn.expand("%:p:h"))
              return vim.fn.expand("%:p:h")
            end,
          }),
        },
      })
    end,
  },
}
