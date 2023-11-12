return {
  { "max397574/better-escape.nvim", event = "InsertEnter", config = true },
  {
    "johmsalas/text-case.nvim",
    config = true,
  },
  {
    "tpope/vim-sleuth",
    event = "BufEnter",
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
  },
  {
    "luukvbaal/nnn.nvim",
    config = true,
    keys = {
      { "<leader>fn", "<cmd>NnnPicker %:p:h<CR>", desc = "Nnn Picker" },
    },
  },
}
