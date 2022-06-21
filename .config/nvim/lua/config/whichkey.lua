local M = {}

function M.setup()
	local whichkey = require("which-key")

	local conf = {
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
		},
	}

	local opts = {
		mode = "n", -- Normal mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	}

	local mappings = {
		["q"] = { "<cmd>q!<CR>", "Quit" },
		["<Leader>"] = { "<cmd>Telescope find_files<CR>", "Project files" },
		[","] = { "<cmd>lua require('telescope.builtin').buffers({ previewer = false})<CR>", "Buffers" },
		["."] = {
			"<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h'), layout_config = { height = 0.2 }, previewer = false })<CR>",
			"Current directory",
		},

		a = {
			name = "Application",
			r = { "<cmd>cd %:p:h | Nnn<cr>", "NNN" },
			t = { "<cmd>ToggleTerm<CR>", "Toggle Terminal" },
		},

		b = {
			name = "Buffer",
			k = { "<cmd>bd!<Cr>", "Close current buffer" },
			K = { "<cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
			["["] = { "<cmd>bprevious<CR>", "Previous buffer" },
			["]"] = { "<cmd>bnext<CR>", "Next buffer" },
		},

		c = {
			name = "Code",
			a = { "<cmd>Lspsaga code_action<CR>", "Code Actions" },
			r = { "<cmd>Lspsaga rename<CR>", "Rename" },
			x = { "<cmd> TroubleToggle document_diagnostics<CR>", "Document Diagnostics" },
			X = { "<cmd> TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics" },
			f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
			o = { "<cmd>TSLspOrganize<CR>", "Organize Imports" },
			R = { "<cmd>TSLspRenameFile<CR>", "Rename File" },
			h = { "<cmd>TSLspToggleInlayHints<CR>", "Toggle Inlay Hints" },
			i = { "<cmd>TSLspImportAll<CR>", "Import All" },
			D = { "<cmd>TroubleToggle lsp_references<CR>", "References" },
			d = { "<cmd>TroubleToggle lsp_definitions<CR>", "Definitions" },
			t = { "<cmd>TroubleToggle lsp_type_definitions<CR>", "Type" },
		},

		f = {
			name = "File",
			s = { "<cmd>update!<CR>", "Save" },
		},

		g = {
			name = "Git",
			g = { "<cmd>Git<CR>", "Status" },
			l = { "<cmd>GV<CR>", "Log" },
		},

		m = {
			name = "Misc",
			l = { "<cmd>lua require('logsitter').log(javascript)<CR>", "Log" },
		},

		p = {
			name = "Projects",
			p = {
				"<cmd>Telescope project theme=ivy layout_config={height=0.2}<CR>",
				"Find Project",
			},
		},

		s = {
			name = "Search",
			r = { "<cmd>lua require('spectre').open()<CR>", "Search & Replace" },
			R = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search & Replace" },
		},

		z = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},
	}

	whichkey.setup(conf)
	whichkey.register(mappings, opts)
end

return M
