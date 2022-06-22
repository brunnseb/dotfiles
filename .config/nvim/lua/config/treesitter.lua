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
		rainbow = {
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},
		context_commentstring = {
			enable = true,
		},
	})
end

return M
