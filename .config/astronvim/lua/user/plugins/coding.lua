return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {
      openai_params = {
        max_tokens = 1000,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "axelvc/template-string.nvim",
    event = "User AstroFile",
    config = function() require("template-string").setup {} end,
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
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function(plugin, opts)
      require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").load { paths = { "/home/brunnseb/.config/astronvim/lua/user/snippets" } } -- load snippets paths
    end,
  },
}
