local M = {}

function M.setup()
	local whichkey = require("which-key")

	local conf = {
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
		},
	}

	if PLUGINS.telescope.enabled then
		keymaps_s = {
			name = "Find",
			f = { "<cmd>Telescope git_files<cr>", "Files" },
			d = {
				'<cmd>lua require(\'telescope.builtin\').find_files({search_dirs = {"~/.doom.d", "~/.config/nvim", "~/.config/fish"},prompt_title = "<Dotfiles>"})<cr>',
				"Dotfiles",
			},
			o = { "<cmd>Telescope oldfiles theme=ivy<cr>", "Old Files" },
			g = { "<cmd>Telescope live_grep hidden=true<cr>", "Live Grep" },
			c = { "<cmd>Telescope commands<cr>", "Commands" },
			r = { "<cmd>Telescope file_browser<cr>", "Browser" },
			b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current Buffer" },
			e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
			p = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Project" },
		}

		keymaps_p = {
			name = "Project",
			p = { "<cmd>Telescope project theme=ivy<cr>", "List" },
			f = { "<cmd>Telescope repo list theme=ivy<cr>", "Find" },
			s = { "<cmd>wa<CR>", "Save" },
		}
	end

	if PLUGINS.fzf_lua.enabled then
		keymaps_s = {
			name = "Find",
			f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
			b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
			o = { "<cmd>FzfLua oldfiles<cr>", "Old Files" },
			g = { "<cmd>FzfLua live_grep<cr>", "Live Grep" },
			c = { "<cmd>FzfLua commands<cr>", "Commands" },
			e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		}
	end

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

		["."] = {
			-- "<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h'), theme = 'ivy' })<CR>",
			"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy({cwd = vim.fn.expand('%:p:h')}))<CR>",
			"Current Directory",
		},

		[","] = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffers" },

		f = {
			name = "File",
			s = { "<cmd>update!<CR>", "Save" },
		},

		p = keymaps_p,

		m = {
			name = "Log",
			l = { "<cmd>Logsitter<CR>", "Log" },
		},

		b = {
			name = "Buffer",
			k = { "<cmd>bd!<Cr>", "Close current buffer" },
			K = { "<cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
			["["] = { "<cmd>bprevious<CR>", "Previous buffer" },
			["]"] = { "<cmd>bnext<CR>", "Next buffer" },
		},

		z = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},

		a = {
			name = "Ranger",
			r = { "<cmd>RnvimrToggle<cr>", "Ranger" },
		},

		w = {
			name = "Window",
			h = "Go to left window",
		},

		o = {
			p = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		},

		s = keymaps_s,
		y = {
			name = "Yank",
			i = { "<cmd>Telescope registers<cr>", "Insert from register" },
		},
		t = {
			name = "Test",
			S = { "<cmd>UltestSummary<cr>", "Summary" },
			a = { "<cmd>Ultest<cr>", "All" },
			d = { "<cmd>UltestDebug<cr>", "Debug" },
			f = { "<cmd>TestFile<cr>", "File" },
			l = { "<cmd>TestLast<cr>", "Last" },
			n = { "<cmd>TestNearest<cr>", "Nearest" },
			o = { "<cmd>UltestOutput<cr>", "Output" },
			s = { "<cmd>TestSuite<cr>", "Suite" },
			v = { "<cmd>TestVisit<cr>", "Visit" },
		},
	}

	whichkey.setup(conf)
	whichkey.register(mappings, opts)
end

return M
