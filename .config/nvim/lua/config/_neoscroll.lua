local M = {}

M.setup = function()
	local neoscroll = require("neoscroll")

	neoscroll.setup({
		mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
	})

	local map = {}

	map["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "80" } }
	map["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "80" } }
	map["<C-y>"] = { "scroll", { "-0.10", "false", "80" } }
	map["<C-e>"] = { "scroll", { "0.10", "false", "80" } }
	map["zt"] = { "zt", { "150" } }
	map["zz"] = { "zz", { "150" } }
	map["zb"] = { "zb", { "150" } }

	require("neoscroll.config").set_mappings(map)
end

return M
