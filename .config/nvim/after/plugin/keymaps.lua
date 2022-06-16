local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- New line on enter
keymap("n", "<CR>", "o<ESC>", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- Window navigation
keymap("n", "<Leader>wh", "<C-w>h", default_opts)
keymap("n", "<Leader>wl", "<C-w>l", default_opts)
keymap("n", "<Leader>wj", "<C-w>j", default_opts)
keymap("n", "<Leader>wk", "<C-w>k", default_opts)
keymap("n", "<Leader>wc", "<C-w>q", default_opts)
keymap("n", "<Leader>wv", "<C-w>v", default_opts)
keymap("n", "<Leader>ws", "<C-w>s", default_opts)
keymap("n", "<Leader>wo", "<C-w>|", default_opts)
keymap("n", "<Leader>w=", "<C-w>=", default_opts)

-- Hop
keymap("n", "gsj", "<cmd>HopLineAC<CR>", default_opts)
keymap("n", "gsk", "<cmd>HopLineBC<CR>", default_opts)
keymap("n", "gs/", "<cmd>HopPattern<CR>", default_opts)
keymap("v", "gsj", "<cmd>HopLineAC<CR>", default_opts)
keymap("v", "gsk", "<cmd>HopLineBC<CR>", default_opts)
keymap("v", "gs/", "<cmd>HopPattern<CR>", default_opts)
