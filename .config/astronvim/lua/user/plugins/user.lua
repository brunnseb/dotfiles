return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  { "phaazon/hop.nvim",       branch = "v2",           config = true, event = "User AstroFile" },
  { "chaoren/vim-wordmotion", event = "User AstroFile" },
  {
    "axelvc/template-string.nvim",
    event = "User AstroFile",
    config = function() require("template-string").setup {} end,
  },
  { "Pocco81/DAPInstall.nvim" },
  {
    "kylechui/nvim-surround",
    event = "User AstroFile",
    config = true,
  },
  {
    "anuvyklack/windows.nvim",
    cmd = {
      "WindowsMaximize",
      "WindowsMaximizeVertically",
      "WindowsMaximizeHorizontally",
      "WindowsEqualize",
      "WindowsEnableAutowidth",
      "WindowsDisableAutowidth",
      "WindowsToggleAutowidth",
    },
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
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
