return {
  {
    "notjedi/nvim-rooter.lua",
    lazy = false,
    config = function()
      require("nvim-rooter").setup {
        rooter_patterns = { "=cockpit-portal", "=awesome", "=astronvim", "=nvim", "lazy-lock.json", ".vscode", ".git" },
        trigger_patterns = { "*" },
        manual = false,
      }
    end,
  },
}
