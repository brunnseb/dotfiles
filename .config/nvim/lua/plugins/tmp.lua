return {
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = { "nvimtools/hydra.nvim" },
    opts = {},
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<Cmd>MCstart<CR>",
        desc = "Create a selection for word under the cursor",
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = { "treesitter" },
      filter_kind = false,
    },
  },
  {
    "hedyhli/outline.nvim",
    enabled = false,
    config = function()
      require("outline").setup({
        providers = {
          priority = { "treesitter", "lsp", "markdown", "norg" },
        },
        symbol_folding = {
          autofold_depth = false,
        },
        outline_items = {
          show_symbol_lineno = true,
        },
      })
    end,
    event = "VeryLazy",
    dependencies = {
      "epheien/outline-treesitter-provider.nvim",
    },
  },
  {
    "chrisgrieser/nvim-early-retirement",
    event = "VeryLazy",
    opts = {
      retirementAgeMins = 10,
    },
  },
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {},
  },
  -- { "folke/noice.nvim", enabled = false },
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },
}
