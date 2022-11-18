local M = {}

function M.setup()
	local default_options = require("user.lsp.defaults")
	local helpers = require("user.lsp.helpers")
	local status_ok, typescript = pcall(require, "typescript")

	if not status_ok then
		return
	end

	typescript.setup({
		disable_commands = false,
		debug = false,
		go_to_source_definition = {
			fallback = true,
		},
		server = vim.tbl_deep_extend("force", default_options, {
			root_dir = function(filename, _)
				return helpers.compose_root_dir(
					{ "tsconfig.json", "jsconfig.json", "*.ts", "*.js", "*.tsx", "*.jsx" },
					filename
				)
			end,
		}),
	})
end

return M
