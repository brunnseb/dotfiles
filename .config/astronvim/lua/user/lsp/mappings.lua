return {
  n = {
    ["<leader>lR"] = { "<cmd>Lspsaga rename ++project<CR>", desc = "Rename in project" },
    ["<leader>lt"] = { "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek type definition" },
    ["<leader>lT"] = { "<cmd>Lspsaga goto_type_definition<CR>", desc = "Go to type definition" },
    ["<leader>la"] = { "<cmd>Lspsaga code_action<CR>", desc = "Code action" },
    ["<leader>lf"] = { "<cmd>Lspsaga lsp_finder<CR>", desc = "Lsp finder" },
    ["<leader>ld"] = { "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
    ["<leader>lD"] = { "<cmd>Lspsaga goto_definition<CR>", desc = "Go to definition" },
    ["<leader>lS"] = { "<cmd>Lspsaga outline<CR>", desc = "Outline" },
    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>" },
  },
}
