return {
  {
    "saghen/blink.cmp",
    opts = {
      per_filetype = {
        codecompanion = { "codecompanion", "path" },
      },
      providers = {
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
          enabled = true,
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").load({
        paths = {
          vim.fn.expand("$HOME/.config/nvim/lua/snippets"),
          vim.fn.expand("$HOME/.local/share/nvim/lazy/friendly-snippets/"),
        },
      })
    end,
  },
}
