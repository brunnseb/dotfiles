return {
  -- guess indent
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
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
  { "ggandor/lightspeed.nvim" },
  { "andymass/vim-matchup" },
  -- {
  --   "notjedi/nvim-rooter.lua",
  --   lazy = false,
  --   config = function()
  --     require("nvim-rooter").setup({
  --       rooter_patterns = { "=cockpit-portal", ".vscode", ".git" },
  --       trigger_patterns = { "*" },
  --       manual = false,
  --     })
  --   end,
  -- },
}
