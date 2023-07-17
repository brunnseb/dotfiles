local M = {}

local function bool2str(bool)
  return bool and 'on' or 'off'
end

function M.toggle_buffer_inlay_hints(bufnr)
  vim.b.inlay_hints_enabled = not vim.b.inlay_hints_enabled
  vim.lsp.inlay_hint(bufnr or 0, vim.b.inlay_hints_enabled)
  vim.notify(string.format('Inlay hints %s', bool2str(vim.b.inlay_hints_enabled)), 'INFO')
end

return M
