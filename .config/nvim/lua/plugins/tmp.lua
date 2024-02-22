return {
  {
    "lewis6991/satellite.nvim",
    opts = {
      width = 50,
    },
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      { "<leader>U", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  {
    "jdrupal-dev/code-refactor.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "CodeActions" },
    keys = {
      { "<leader>cR", "<cmd>CodeActions all<CR>", desc = "Show code-refactor.nvim (not LSP code actions)" },
    },
    config = function()
      require("code-refactor").setup({
        -- Configuration here, or leave empty to use defaults.
      })
    end,
  },
  -- {
  --
  --   "hinell/lsp-timeout.nvim",
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   init = function()
  --     vim.g.lspTimeoutConfig = {
  --       stopTimeout = 1000 * 60 * 5, -- ms, timeout before stopping all LSPs
  --       startTimeout = 1000 * 10, -- ms, timeout before restart
  --       silent = false, -- true to suppress notifications
  --       filetypes = {
  --         ignore = { -- filetypes to ignore; empty by default
  --           -- lsp-timeout is disabled completely
  --         }, -- for these filetypes
  --       },
  --     }
  --   end,
  -- },
}
