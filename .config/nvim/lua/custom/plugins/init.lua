return {
  ["max397574/better-escape.nvim"] = {
    config = function()
      require("better_escape").setup {
         mapping = {"jk"},
      }
    end,
  },
  ["francoiscabrol/ranger.vim"] = {},
  ["olambo/vi-viz"] = {}
}