local M = {}

function M.setup()
	local default_options = require("user.lsp.defaults")
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
		server = default_options,
	})
end

return M
