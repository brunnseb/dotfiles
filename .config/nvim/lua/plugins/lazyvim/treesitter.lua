return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gm",
          node_incremental = "m",
          scope_incremental = false,
          node_decremental = "n",
        },
      },
    },
  },
}
