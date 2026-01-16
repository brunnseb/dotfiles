return {
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>z",
          insert_line = "<C-g>Z",
          normal = "gz",
          normal_line = "gZ",
          normal_cur = "gzz",
          normal_cur_line = "gZZ",
          visual = "gz",
          visual_line = "gZ",
          delete = "gzd",
          change = "gzc",
        },
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
}
