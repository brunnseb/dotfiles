return {
  -- guess indent
  {
    "nmac427/guess-indent.nvim",
    config = true,
  },
  {
    "max397574/better-escape.nvim",
    config = true,
  },
  { "chaoren/vim-wordmotion" },
  {
    "axelvc/template-string.nvim",
    config = function()
      require("template-string").setup({})
    end,
  },
  { "gaelph/logsitter.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  {
    "kylechui/nvim-surround",
    config = true,
  },
  { "ggandor/lightspeed.nvim", opts = {
    ignore_case = true,
  } },
  { "andymass/vim-matchup" },
  { "mg979/vim-visual-multi" },
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
    config = function()
      require("nvim-rooter").setup({
        rooter_patterns = { "=cockpit-portal", "lazy-lock.json", ".vscode", ".git" },
        trigger_patterns = { "*" },
        manual = false,
      })
    end,
  },
}
