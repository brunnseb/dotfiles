local M = {}

function M.setup()
	local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end
	treesitter.setup({
		ensure_installed = {
			"tsx",
			"lua",
			"typescript",
			"css",
			"scss",
			"json",
			"html",
			"yaml",
			"bash",
			"astro",
			"comment",
			"dockerfile",
			"dot",
			"fish",
			"graphql",
			"javascript",
			"markdown",
			"norg",
			"jsdoc",
			"regex",
			"sql",
			"svelte",
			"vim",
			"vue",
		},
		-- Automatically install missing parsers when entering buffer
		auto_install = true,
		highlight = {
			-- `false` will disable the whole extension
			enable = true,
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gm",
				node_incremental = "m",
				scope_incremental = "M",
				node_decremental = "n",
			},
		},
		indent = {
			enable = false,
		},
		rainbow = {
			enable = true,
			extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},
		autotag = {
			enable = true,
		},
	})
end

return M
