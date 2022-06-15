local M = {}

function M.setup()
	local logsitter = require("logsitter")
	local javascript = require("logsitter.lang.javascript")

	logsitter.register(javascript, {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"svelte",
	})
end

return M
