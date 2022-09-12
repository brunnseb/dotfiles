local M = {}
local default = require('user.lsp.servers.default')

M.on_attach = default.on_attach

M.flags = default.lsp_flags

local capabilities = default.capabilities

capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities

M.filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' }

return M
