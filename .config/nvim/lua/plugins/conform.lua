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
          require("none-ls.diagnostics.eslint_d"), -- requires none-ls-extras.nvim
          require("none-ls.code_actions.eslint_d"),
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "eslint_d", "prettierd" },
        javascriptreact = { "eslint_d", "prettierd" },
        typescript = { "eslint_d", "prettierd" },
        typescriptreact = { "eslint_d", "prettierd" },
      },
    },
  },
}
