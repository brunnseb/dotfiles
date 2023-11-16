return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "andymass/vim-matchup",
    },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gm",
          node_incremental = "gm",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      matchup = {
        enable = true,
      },
    },
  },
}
