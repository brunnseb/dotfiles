return {
  "Saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
    -- keymap = {
    --   ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    --   ["<Up>"] = { "select_prev", "fallback" },
    --   ["<Down>"] = { "select_next", "fallback" },
    --   ["<C-N>"] = { "select_next", "show" },
    --   ["<C-P>"] = { "select_prev", "show" },
    --   ["<C-J>"] = { "select_next", "fallback" },
    --   ["<C-K>"] = { "select_prev", "fallback" },
    --   ["<C-U>"] = { "scroll_documentation_up", "fallback" },
    --   ["<C-D>"] = { "scroll_documentation_down", "fallback" },
    --   ["<C-e>"] = { "hide", "fallback" },
    --   ["<CR>"] = { "accept", "fallback" },
    --   ["<Tab>"] = {
    --     "select_next",
    --     "snippet_forward",
    --     function(cmp)
    --       if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
    --     end,
    --     "fallback",
    --   },
    --   ["<S-Tab>"] = {
    --     "select_prev",
    --     "snippet_backward",
    --     function(cmp)
    --       if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
    --     end,
    --     "fallback",
    --   },
    -- },
    completion = {
      trigger = {
        show_in_snippet = false,
      },
      list = { selection = { preselect = true, auto_insert = true } },
    },
  },
}
