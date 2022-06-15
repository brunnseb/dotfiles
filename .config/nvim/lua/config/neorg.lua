local M = {}

function M.setup()
	local status_ok, neorg = pcall(require, "neorg")
	if not status_ok then
		return
	end
	neorg.setup({
		load = {
			["core.defaults"] = {},
			["core.gtd.base"] = {
				config = {
					workspace = "gtd",
				},
			},
			["core.norg.concealer"] = {},
			["core.norg.dirman"] = {
				config = {
					workspaces = {
						gtd = "~/norg/gtd",
						gkeep = "~/gkeep",
						work = "~/norg/work",
					},
					autochdir = true, -- Automatically change the directory to the current workspace's root every time
					index = "index.norg", -- The name of the main (root) .norg file
				},
			},
			["core.norg.journal"] = {},
			["core.norg.qol.toc"] = {},
			["core.integrations.telescope"] = {},
		},
	})
end

return M
