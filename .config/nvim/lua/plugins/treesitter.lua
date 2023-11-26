return {

  {
    "nvim-treesitter/nvim-treesitter",

    dependencies = {
      "andymass/vim-matchup",
    },
    opts = {
      matchup = {
        enable = true,
      },
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = { "html", "xml", "typescriptreact", "javascriptreact" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gm",
          node_incremental = "m",
          scope_incremental = "M",
          node_decremental = "n",
        },
      },
    },
  },
}
