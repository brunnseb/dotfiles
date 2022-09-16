local M = {}

function M.go_to_definition()
	if not vim.fn.exists(":TypescriptGoToSourceDefinition") == 0 then
		require("typescript").goToSourceDefinition(vim.fn.win_getid(), {})
	else
		vim.lsp.buf.definition()
	end
end

function M.organize_imports()
	local typescript = require("typescript")
	typescript.actions.removeUnused({ sync = true })
	typescript.actions.organizeImports({ sync = true })
end

return M
