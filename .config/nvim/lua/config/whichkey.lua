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
			f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
			d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
			b = { "<cmd>Telescope buffers<cr>", "Buffers" },
			o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
			g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
			c = { "<cmd>Telescope commands<cr>", "Commands" },
			r = { "<cmd>Telescope file_browser<cr>", "Browser" },
			w = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current Buffer" },
			e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		}

		keymaps_p = {
			name = "Project",
			p = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "List" },
			f = { "<cmd>Telescope repo list<cr>", "Find" },
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

		g = {
			name = "Git",
			g = { "<cmd>LazyGit<CR>", "Status" },
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
	}

	whichkey.setup(conf)
	whichkey.register(mappings, opts)
end

return M
