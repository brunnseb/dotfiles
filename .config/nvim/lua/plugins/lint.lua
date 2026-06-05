return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          require("none-ls.code_actions.eslint_d"),
        },
      })
    end,
  },
  {

    "mfussenegger/nvim-lint",
    opts = {
      events = { "BufWritePost", "BufReadPost" },
      linters_by_ft = {
        fish = { "fish" },
        typescriptreact = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        javascript = { "eslint_d" },
      },
    },
  },
}
