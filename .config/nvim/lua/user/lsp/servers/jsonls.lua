local M = {}
local default = require('user.lsp.servers.default')

M.settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
}

M.setup = {
    commands = {
      Format = {
        function() vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 }) end,
      },
    },
}

M.flags = default.lsp_flags

M.on_attach = default.on_attach

local capabilities = default.capabilities

capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities

return M
