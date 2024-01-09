return {
  "axkirillov/hbac.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  name = "hbac",
  opts = {
    autoclose = true,
    threshold = 900, -- 15 minutes
  },
}
