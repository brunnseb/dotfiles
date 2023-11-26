return {
  {
    "tpope/vim-sleuth",
    event = "BufEnter",
  },
  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
  },
  { "pixelastic/vim-undodir-tree" },
}
