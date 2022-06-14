local M = {}

function M.setup()
  local whichkey = require "which-key"

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

		f = {
			name = "File",
			s = { "<cmd>update!<CR>", "Save" },
		},

		p = {
			name = "Project",
			s = { "<cmd>wa<CR>", "Save" },
		},

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
			r = { "<cmd>Ranger<cr>", "Ranger"},
		},

		w = {
			name = "Window",
			h =  "Go to left window",
		}
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
