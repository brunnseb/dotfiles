return {
  { "lambdalisue/suda.vim", event = "VeryLazy" },
  {
    "notjedi/nvim-rooter.lua",
    lazy = false,
    config = function()
      require("nvim-rooter").setup {
        rooter_patterns = { "=hypr", "=eww", "=astronvim", "=nvim", "package.json", ".vscode", ".git" },
        trigger_patterns = { "*" },
        manual = false,
      }
    end,
  },
}
