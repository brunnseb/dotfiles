local M = {}

function M.on_attach(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if client.server_capabilities.colorProvider then
		-- Attach document colour support
		require("document-color").buf_attach(bufnr)
	end
end

M.flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

capabilities.textDocument.colorProvider = {
	dynamicRegistration = true,
}

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if cmp_nvim_lsp_ok then
	capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

M.capabilities = capabilities

return M
