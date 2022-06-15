local M = {}

local whichkey = require("which-key")

local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
	local opts = { noremap = true, silent = true }

	-- Key mappings
	buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
	keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)

	-- Whichkey
	local keymap_c = {
		c = {
			name = "Code",
			D = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
			a = { "<cmd>CodeActionMenu<CR>", "Code Action" },
			x = { "<cmd>Trouble document_diagnostics<CR>", "Diagnostics" },
			X = { "<cmd>Trouble workspace_diagnostics<CR>", "Workspace Diagnostics" },
			h = { "<cmd>TSLspToggleInlayHints<CR>", "Toggle Inlay Hints" },
			i = { "<cmd>LspInfo<CR>", "Lsp Info" },
			I = { "<cmd>TSLspImportAll<CR>", "Import All" },
			r = { "<cmd>Lspsaga rename<CR>", "Rename" },
			R = { "<cmd>TSLspRenameFile<CR>", "Rename File" },
			d = { "<cmd>TroubleToggle lsp_definitions<CR>", "Trouble Definitions" },
			k = { "<cmd>TroubleToggle lsp_type_definitions<CR>", "Trouble Type Definitions" },
			o = { "<cmd>:TSLspOrganize<CR>", "Organize Imports" },
		},
	}

	local keymap_g = {
		name = "Goto",
		d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
		t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
	}
	whichkey.register(keymap_c, { buffer = bufnr, prefix = "<leader>" })
	whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })
end

function M.setup(client, bufnr)
	keymappings(client, bufnr)
end

return M
