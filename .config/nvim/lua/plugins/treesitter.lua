return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "mrjones2014/nvim-ts-rainbow",
      "windwp/nvim-ts-autotag",
    },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gm",
          node_incremental = "m",
          scope_incremental = "M",
          node_decremental = "n",
        },
      },
      autotag = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
    },
  },
}
