return {
  {
    "kylechui/nvim-surround",
    event = "User AstroFile",
    config = true,
  },
  {
    "axelvc/template-string.nvim",
    event = "User AstroFile",
    config = function() require("template-string").setup {} end,
  },
}
