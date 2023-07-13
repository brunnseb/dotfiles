return {
  {
    "uga-rosa/translate.nvim",
    cmd = { "Translate" },
    opts = require "user.config.translate-nvim",
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = require "user.config.chatgpt-nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "axelvc/template-string.nvim",
    event = "User AstroFile",
    config = true,
  },
  {
    "gaelph/logsitter.nvim",
    event = "User AstroFile",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "abecodes/tabout.nvim",
    dependencies = { "nvim-treesitter" },
    event = "VeryLazy",
  },
  { "mg979/vim-visual-multi", event = "User AstroFile" },
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
}
