local M = {}

M.setup = function()
	require("nvim-treesitter.configs").setup({
		-- A list of parser names, or "all"
		ensure_installed = {
			"norg",
			"lua",
			"typescript",
			"javascript",
			"css",
			"json",
			"yaml",
			"svelte",
			"graphql",
			"scss",
			"bash",
			"fish",
			"hocon",
			"html",
			"jsdoc",
			"regex",
			"tsx",
		},
		highlight = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gm",
				node_incremental = "gj",
				scope_incremental = "gJ",
				node_decremental = "gk",
			},
		},
	})
end

return M
