return {
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = {
        ["_"] = { "treesitter", "lsp" },
        lua = { "lsp" },
      },
      keymaps = {
        ["<Right>"] = "actions.tree_open",
        ["<S-Right>"] = "actions.tree_open_recursive",
        ["<Left>"] = "actions.tree_close",
        ["<S-Left>"] = "actions.tree_close_recursive",
      },
      autojump = true,
      icons = {
        Struct = " ",
      },
      show_guides = true,
      filter_kind = false,
      nav = {
        keymaps = {
          ["<Left>"] = "actions.left",
          ["<Right>"] = "actions.right",
          ["q"] = "actions.close",
        },
        preview = true,
      },
      on_first_symbols = function(bufnr) require("aerial").tree_set_collapse_level(bufnr, 2) end,
    },
  },
}
