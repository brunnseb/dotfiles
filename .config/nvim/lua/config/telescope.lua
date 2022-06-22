local M = {}

function M.setup()
	local actions = require("telescope.actions")
	local telescope = require("telescope")

	telescope.setup({
		defaults = {
			-- Default configuration for telescope goes here:
			-- config_key = value,
			mappings = {
				i = {
					-- map actions.which_key to <C-h> (default: <C-/>)
					-- actions.which_key shows the mappings for your picker,
					-- e.g. git_{create, delete, ...}_branch for the git_branches picker
					["<C-h>"] = "which_key",
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
				},
			},
		},
		pickers = {
			find_files = {
				theme = "ivy",
			},
			buffers = {
				theme = "ivy",
				layout_config = {
					height = 0.2,
				},
			},
			projects = {
				theme = "ivy",
				layout_config = {
					height = 0.2,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
	require("neoclip").setup()

	-- To get fzf loaded and working with telescope, you need to call
	-- load_extension, somewhere after setup function:
	telescope.load_extension("fzf")
	telescope.load_extension("project")
	telescope.load_extension("neoclip")
end

return M
