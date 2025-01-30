return {
  { "nvchad/volt", lazy = true },
  {
    "nvchad/ui",
    priority = 1000,
    event = "VeryLazy",
    keys = {
      { "<leader>uC", '<cmd>lua require("nvchad.themes").open()<CR>', desc = "Colorscheme" },
    },
    config = function()
      require("nvchad")
    end,
  },
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
}
