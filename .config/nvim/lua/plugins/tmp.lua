return {
  {
    "jdrupal-dev/code-refactor.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "CodeActions" },
    -- keys = {
    --   { "<leader>cc", "<cmd>CodeActions all<CR>", desc = "Show code-refactor.nvim (not LSP code actions)" },
    -- },
    config = function()
      require("code-refactor").setup({
        -- Configuration here, or leave empty to use defaults.
      })
    end,
  },
  { "RaafatTurki/corn.nvim", config = true },
}
