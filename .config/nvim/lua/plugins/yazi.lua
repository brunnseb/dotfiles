return {
  {
    "DreamMaoMao/yazi.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>fn", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
    },
  },
}
