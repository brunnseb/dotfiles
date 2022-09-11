
local M = {}
local default = require('user.lsp.servers.default')

M.on_attach = default.on_attach

M.flags = default.lsp_flags

M.capabilities = default.capabilities

return M
