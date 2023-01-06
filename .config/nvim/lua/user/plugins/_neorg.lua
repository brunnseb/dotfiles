local M = {}

function M.setup()
	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.norg.dirman"] = {
				config = {
					workspaces = {
						work = "~/Documents/neorg/work",
						personal = "~/Documents/neorg/personal",
						gtd = "~/Documents/neorg/gtd",
					},
				},
			},
			-- ["core.gtd.base"] = {
			-- 	config = {
			-- 		workspace = "gtd",
			-- 	},
			-- },
			["core.norg.concealer"] = {},
			["core.export"] = {},

			["core.integrations.telescope"] = {},
		},
	})
end

return M
