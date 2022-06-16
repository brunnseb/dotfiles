local M = {}

M.setup = function()
	-- local augroup = vim.api.nvim_create_augroup("ImportCost", {})
	--
	-- vim.api.nvim_clear_autocmds({ group = augroup })
	-- vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter", "CursorHold" }, {
	-- 	group = augroup,
	-- 	pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.svelte" },
	-- 	command = "ImportCost",
	-- })
end

return M
