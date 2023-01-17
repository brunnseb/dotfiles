local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)

-- vim.g.mapleader = " "

-- vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Lsp
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "zk", "<cmd>lua require('ufo').peekFoldedLinesUnderCursor()<CR>", opts)
vim.keymap.set("n", "<leader>cr", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

keymap("n", "gd", "<cmd>lua require('custom.functions').go_to_definition()<CR>", opts)
keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", opts)
keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", opts)

-- Telescope
keymap("n", "<S-p>", "<CMD>lua require('custom.multi-rg')()<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Navigate to occurence
keymap("n", "gj", "*", opts)
keymap("n", "gk", "#", opts)

keymap("n", "gs/", "<cmd>HopPattern<CR>", opts)
keymap("n", "gsk", "<cmd>HopLineBC<CR>", opts)
keymap("n", "gsj", "<cmd>HopLineAC<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Hop
keymap("v", "gs/", "<cmd>lua require('hop').hint_patterns()<CR>", opts)
keymap(
	"v",
	"gsk",
	"<cmd>lua require('hop').hint_lines({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<CR>",
	opts
)
keymap(
	"v",
	"gsj",
	"<cmd>lua require('hop').hint_lines({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<CR>",
	opts
)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
