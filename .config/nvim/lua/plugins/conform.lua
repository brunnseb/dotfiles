return {
  -- {
  --   "nvimtools/none-ls.nvim",
  --   dependencies = {
  --     "nvimtools/none-ls-extras.nvim",
  --   },
  --   config = function()
  --     local null_ls = require("null-ls")
  --
  --     null_ls.setup({
  --       sources = {
  --         require("none-ls.diagnostics.eslint_d"), -- requires none-ls-extras.nvim
  --         require("none-ls.code_actions.eslint_d"),
  --       },
  --     })
  --   end,
  -- },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettierd", lsp_format = "never" },
        javascript = { "prettierd", lsp_format = "never" },
        javascriptreact = { "prettierd", lsp_format = "never" },
        typescript = { "prettierd", lsp_format = "never" },
        typescriptreact = { "prettierd", "eslint_d", lsp_format = "never", timeout = 5000 },
      },
    },
  },
}
