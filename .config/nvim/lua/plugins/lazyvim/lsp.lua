return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = function(_, opts)
      dofile(vim.g.base46_cache .. "semantic_tokens")
      dofile(vim.g.base46_cache .. "lsp")

      return vim.tbl_deep_extend("force", opts, {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = false,
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
      })
    end,
  },
  {
    "mason.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        dofile(vim.g.base46_cache .. "mason")
      end,
    },
  },
}
