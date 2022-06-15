local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

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

-- Telescope
-- keymap("n", "<Leader>,", "<cmd>Telescope buffers<CR>", default_opts)
-- keymap("n", "<Leader><Leader>", "<cmd>Telescope find_files<CR>", default_opts)
-- keymap("n", "<Leader>sp", "<cmd>Telescope grep_string<CR>", default_opts)
-- keymap("n", "<Leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", default_opts)
-- keymap("n", "<Leader>jl", "<cmd>Telescope jumplist<CR>", default_opts)
-- keymap("n", "<Leader>yi", "<cmd>Telescope registers<CR>", default_opts)

-- Telescope project
-- keymap("n", "<Leader>pp", "<cmd>lua require('telescope').extensions.project.project()<CR>", default_opts)

keymap("n", "gsj", "<cmd>HopLineAC<CR>", default_opts)
keymap("n", "gsk", "<cmd>HopLineBC<CR>", default_opts)
keymap("n", "gs/", "<cmd>HopPattern<CR>", default_opts)
keymap("v", "gsj", "<cmd>HopLineAC<CR>", default_opts)
keymap("v", "gsk", "<cmd>HopLineBC<CR>", default_opts)
keymap("v", "gs/", "<cmd>HopPattern<CR>", default_opts)
-- Expand Region
-- keymap("n", "gm", "<cmd>lua require('vi-viz').vizInit()<CR>", default_opts)
-- keymap("x", "m", "<cmd>lua require('vi-viz').vizExpand()<CR>", default_opts)
-- keymap("x", "n", "<cmd>lua require('vi-viz').vizContract()<CR>", default_opts)
-- expand and contract by 1 char either side
-- keymap("x", "l", "<cmd>lua require('vi-viz').vizExpand1Chr()<CR>", default_opts)
-- keymap("x", "h", "<cmd>lua require('vi-viz').vizContract1Chr()<CR>", default_opts)
-- -- good use for the r key in visual mode
-- keymap("x", "r", "<cmd>lua require('vi-viz').vizPattern()<CR>", default_opts)
-- -- nice to have to get dot repeat on single words
-- keymap("x", "u", "<cmd>lua require('vi-viz').vizChange()<CR>", default_opts)
-- -- nice to have to insert before and after
-- keymap("x", "ii", "<cmd>lua require('vi-viz').vizInsert()<CR>", default_opts)
-- keymap("x", "aa", "<cmd>lua require('vi-viz').vizAppend()<CR>", default_opts)
-- Quit
-- keymap("n", "q", ":close<CR>", default_opts)
