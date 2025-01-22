return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = false },
      },
      keymap = { preset = "super-tab" },
      signature = { enabled = false },
      sources = {
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
  {
    "gbprod/yanky.nvim",
    keys = {
      {
        "<leader>P",
        function()
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.yank_history.yank_history({})
          else
            vim.cmd([[YankyRingHistory]])
          end
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
  },
}
