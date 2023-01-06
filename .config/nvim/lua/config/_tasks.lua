local M = {}

function M.setup()
	require("vstask").setup({
		cache_strategy = "last", -- can be "most" or "last" (most used / last used)
		telescope_keys = { -- change the telescope bindings used to launch tasks
			split = "<CR>",
		},
		autodetect = { -- auto load scripts
			npm = "on",
		},
		terminal = "toggleterm",
	})
end

return M
