local M = {}

function M.setup()
	local lsp = require("lsp-zero")

	lsp.preset("recommended")
	lsp.nvim_workspace()
	lsp.setup()
end

return M
