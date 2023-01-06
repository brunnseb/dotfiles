local icons = {
	warn = "⚠",
	info = "",
	error = "",
	hint = "",
	debug = " ",
}

vim.fn.sign_define("DiagnosticSignError", { text = icons.error, texthl = "DiagnosticSignError", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = icons.warn, texthl = "DiagnosticSignWarn", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = icons.hint, texthl = "DiagnosticSignHint", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = icons.info, texthl = "DiagnosticSignInfo", numhl = "" })

local function format(diagnostic)
	local icon = icons.error
	if diagnostic.severity == vim.diagnostic.severity.WARN then
		icon = icons.warn
	end

	if diagnostic.severity == vim.diagnostic.severity.HINT then
		icon = icons.hint
	end

	local message = string.format(" %s [%s][%s] %s", icon, diagnostic.code, diagnostic.source, diagnostic.message)
	return message
end

vim.diagnostic.config({
	underline = true,
	signs = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		focusable = false,
		header = { icons.debug .. " Diagnostics:", "Normal" },
		scope = "line",
		source = false,
		format = format,
	},
	virtual_text = {
		prefix = "•",
		spacing = 2,
		source = false,
		severity = {
			min = vim.diagnostic.severity.HINT,
		},
		format = format,
	},
})
