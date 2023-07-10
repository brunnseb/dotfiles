return {
  {
    "goolord/alpha-nvim",
    opts = require "user.config.alpha-nvim",
  },
  {
    "hrsh7th/nvim-cmp",
    opts = require "user.config.nvim-cmp",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "user.config.nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/playground" },
      { "andymass/vim-matchup" },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function(plugin, opts) require("user.config.luasnip").setup(plugin, opts) end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-live-grep-args.nvim" },
    config = function(_, opts) require("user.config.telescope").setup(opts) end,
  },
  {
    "notjedi/nvim-rooter.lua",
    lazy = false,
    opts = require "user.config.nvim-rooter",
  },
  {
    "anuvyklack/hydra.nvim",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = require "user.config.neo-tree-nvim",
  },
  {
    "kevinhwang91/nvim-ufo",
    config = function() require("user.config.nvim-ufo").setup() end,
  },
  { "luukvbaal/nnn.nvim", cmd = { "NnnPicker", "NnnExplorer" }, config = true },

  {
    "rcarriga/nvim-notify",
    opts = require "user.config.nvim-notify",
  },
}
