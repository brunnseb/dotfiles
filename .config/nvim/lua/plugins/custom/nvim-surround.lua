return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "BufEnter",
    opts = {
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "gsr",
        normal_cur = "gsa",
        normal_line = "gsR",
        normal_cur_line = "gsA",
        visual = ";",
        visual_line = "gS",
        delete = "gsd",
        change = "gsc",
        change_line = "gsC",
      },
    },
  },
}
