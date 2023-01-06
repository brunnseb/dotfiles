local M = {}

function M.setup()
	require("zen-mode").setup({
		window = {
			backdrop = 0.8,
		},
		plugins = {
			gitsigns = { enabled = true },
			kitty = {
				enabled = true,
				font = "+3", -- font size increment
			},
		},
		on_open = function()
			require("gitsigns").toggle_signs()
		end,
	})
end

return M
