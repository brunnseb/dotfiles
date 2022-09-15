local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["<Leader>"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 0.25 }}))<CR>",
		"Project files",
	},
	[","] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 0.25 }}))<CR>",
		"Buffers",
	},
	["."] = {
		"<cmd>lua require('telescope.builtin').find_files( require('telescope.themes').get_ivy({ cwd = vim.fn.expand('%:p:h'), layout_config = { height = 0.25 }, previewer = false }))<CR>",
		"Current directory",
	},
	b = {
		name = "Buffer",
		k = { "<cmd>bp | sp | bn | bd<Cr>", "Close current buffer" },
		K = { "<cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
	},

	c = {
		name = "Code",
		l = { "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", "Line diagnostics" },
		D = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
		R = { "<cmd>TypescriptRenameFile<CR>", "Rename file" },
		a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
		d = { "<cmd>lua require('user.custom.functions').go_to_definition()<CR>", "Definition" },
		f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
		o = "Organize imports",
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		t = "Type definition",
		w = {
			name = "Workspace",
			a = "Add",
			l = "List",
			r = "Remove",
		},
		x = { "<cmd>Trouble document_diagnostics<CR>", "Diagnostics" },
		X = { "<cmd>Trouble workspace_diagnostics<CR>", "Workspace diagnostics" },
	},
	d = {
		name = "Diffview",
	},
	f = {
		name = "File",
		s = {
			"<cmd>update! | lua vim.notify(vim.api.nvim_buf_get_name(0).. ' successfully saved', vim.log.levels.INFO, { timeout = 500, title = 'Info' })<CR>",
			"Save",
		},
	},
	g = {
		name = "Git",
		B = { "<cmd> lua require('agitator').git_blame_toggle()<CR>", "Blame file" },
		b = { "<cmd> lua require('gitsigns').toggle_current_line_blame()<CR>", "Blame line" },
		d = { "<cmd> lua require('gitsigns').diffthis()<CR>", "Diff file" },
		f = { "<cmd> lua require('agitator').open_file_git_branch()<CR>", "Find file" },
		g = { "<cmd>Neogit<CR>", "Status" },
		h = {
			name = "Hunk",
			p = { "<cmd> lua require('gitsigns').preview_hunk()<CR>", "Preview" },
			s = { "<cmd> lua require('gitsigns').stage_hunk()<CR>", "Stage" },
			u = { "<cmd> lua require('gitsigns').undo_stage_hunk()<CR>", "Undo stage" },
			r = { "<cmd> lua require('gitsigns').reset_hunk()<CR>", "Reset" },
		},
		s = { "<cmd> lua require('agitator').search_git_branch()<CR>", "Search in branch" },
		t = { "<cmd> lua require('agitator').git_time_machine()<CR>", "Timemachine" },
	},
	o = {
		name = "Open",
		p = { "<cmd>NeoTreeRevealToggle<CR>", "Neotree" },
		r = { "<cmd>NnnPicker %:p:h<CR>", "Nnn" },
	},
	p = {
		name = "Project",
		p = {
			"<cmd>lua require'telescope'.extensions.repo.list(require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 0.4 }, file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%qmk_firmware/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh', '/Library/', '/%.cocoapods/'}}))<CR>",
			"List",
		},
		s = { "wa", "Save all" },
	},
	w = {
		name = "Window",
		c = { "<C-w>q", "close window" },
		h = { "<C-w>h", "go to left window" },
		j = { "<C-w>j", "go to bottom window" },
		k = { "<C-w>k", "go to top window" },
		l = { "<C-w>l", "go to right window" },
		s = { "<C-w>s", "split horizontal" },
		v = { "<C-w>v", "split vertical" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
vim.keymap.set("n", "<space>cwa", vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set("n", "<space>cwr", vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set("n", "<space>cwl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set("n", "<space>ct", vim.lsp.buf.type_definition, bufopts)
vim.keymap.set("n", "<space>cf", vim.lsp.buf.formatting, bufopts)
