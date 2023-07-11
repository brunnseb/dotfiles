return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",

  -- Color
  { import = "astrocommunity.color.modes-nvim" },
  {
    "modes.nvim",
    opts = require "user.config.modes-nvim",
  },
  -- Colorschemes
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    -- further customize the options set by the community
    "catppuccin",
    config = function() require("user.config.catppuccin").setup() end,
  },
  -- LSP
  -- Language packs
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.dart" },
  -- Utility
  { import = "astrocommunity.utility.neodim" },
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = require "user.config.noice-nvim",
  },
  -- Debugging
  { import = "astrocommunity.debugging.nvim-bqf" },
  -- Diagnostics
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- Editor
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    dependencies = { "folke/twilight.nvim" },
    opts = require "user.config.zen-mode-nvim",
  },
  { import = "astrocommunity.editing-support.text-case-nvim" },
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

  -- Markdown
  { import = "astrocommunity.markdown-and-latex.glow-nvim" },
  -- Motion
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.motion.mini-bracketed" },
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.motion.flash-nvim" },
  {
    "folke/flash.nvim",
    keys = {
      {
        "m",
        mode = { "n", "x", "o" },
        function() require("flash").jump() end,
        desc = "Flash",
      },
      {
        "M",
        mode = { "n", "o", "x" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Flash Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc = "Toggle Flash Search",
      },
    },
  },
  -- Project
  { import = "astrocommunity.project.nvim-spectre" },
  {
    "nvim-pack/nvim-spectre",
    config = function(_, opts) require("user.config.nvim-spectre").setup(opts) end,
  },
  -- Split and Windows
  { import = "astrocommunity.split-and-window.windows-nvim" },
  -- Programming Language Support
  { import = "astrocommunity.programming-language-support.nvim-jqx" },
}
