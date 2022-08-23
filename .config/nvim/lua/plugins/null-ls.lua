local M = {}

M.setup = function()
	local null_ls = require("null-ls")
	-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	if not null_ls then
		return
	end

	local format = null_ls.builtins.formatting
	-- local diagnostic = null_ls.builtins.diagnostics

	null_ls.setup({
		sources = {
			-- diagnostic.eslint,
			format.prettierd,
			-- format.stylua,
		},
		on_attach = function(client, bufnr)
			local callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(client)
						return client.name == "null-ls"
					end,
				})
			end

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = callback,
				})
			end
		end,
	})
end

return M
