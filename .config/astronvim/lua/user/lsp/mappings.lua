return {
  n = {
    -- ["<leader>lr"] = { "<cmd>Lspsaga rename<CR>", desc = "Rename in project" },
    ["<leader>lR"] = { "<cmd>Lspsaga rename ++project<CR>", desc = "Rename in project" },
    ["<leader>lT"] = { "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek type definition" },
    ["<leader>lt"] = { "<cmd>Lspsaga goto_type_definition<CR>", desc = "Go to type definition" },
    ["<leader>la"] = { "<cmd>Lspsaga code_action<CR>", desc = "Code action" },
    ["<leader>lf"] = { "<cmd>Lspsaga finder<CR>", desc = "Lsp finder" },
    ["<leader>lD"] = { "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
    ["<leader>ld"] = { "<cmd>Lspsaga goto_definition<CR>", desc = "Go to definition" },
    ["<leader>lS"] = { "<cmd>SymbolsOutline<CR>", desc = "Outline" },
    ["<leader>lh"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Line diagnostics" },
    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>" },
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>" },
  },
}
