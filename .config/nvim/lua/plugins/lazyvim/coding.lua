return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      -- completion = {
      --   accept = { auto_brackets = { enabled = false } },
      --   documentation = { auto_show = false },
      -- },
      -- signature = { enabled = false },
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
          snippets = {
            name = "Snippets",
            module = "blink.cmp.sources.snippets",
            score_offset = 0,
          },
        },
      },
    },
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
