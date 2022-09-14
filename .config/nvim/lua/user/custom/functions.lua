local M = {}

function M.go_to_definition()
	if not vim.fn.exists(":TypescriptGoToSourceDefinition") == 0 then
		require("typescript").goToSourceDefinition(vim.fn.win_getid(), {})
	else
		vim.lsp.buf.definition()
	end
end

return M
