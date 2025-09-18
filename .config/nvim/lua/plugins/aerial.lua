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
      -- on_first_symbols = function(bufnr) require("aerial").tree_set_collapse_level(bufnr, 2) end,
    },
    keys = {
      { "z0", "<CMD>lua require('aerial').tree_set_collapse_level(0, 0)<CR>", desc = "Fold collapse level 0" },
      { "z1", "<CMD>lua require('aerial').tree_set_collapse_level(0, 1)<CR>", desc = "Fold collapse level 1" },
      { "z2", "<CMD>lua require('aerial').tree_set_collapse_level(0, 2)<CR>", desc = "Fold collapse level 2" },
      { "z3", "<CMD>lua require('aerial').tree_set_collapse_level(0, 3)<CR>", desc = "Fold collapse level 3" },
      { "z4", "<CMD>lua require('aerial').tree_set_collapse_level(0, 4)<CR>", desc = "Fold collapse level 4" },
    },
  },
}
