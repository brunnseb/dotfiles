local M = {}
local default = require('user.lsp.servers.default')

function M.on_attach(client, bufnr)
  default.on_attach(client, bufnr)

  local status_ok, ts_utils = pcall(require, 'nvim-lsp-ts-utils')

  if not status_ok then
    return
  end

  -- defaults
  ts_utils.setup({
    debug = false,
    disable_commands = false,
    enable_import_on_completion = true,

    -- import all
    import_all_timeout = 5000, -- ms
    import_all_priorities = {
      buffers = 4, -- loaded buffer names
      buffer_content = 3, -- loaded buffer content
      local_files = 2, -- git files or files with relative path markers
      same_file = 1, -- add to existing import statement
    },
    import_all_scan_buffers = 100,
    import_all_select_source = false,

    -- inlay hints
    auto_inlay_hints = true,
    inlay_hints_highlight = 'Comment',

    -- update imports on file move
    update_imports_on_move = true,
    require_confirmation_on_move = false,
    watch_dir = nil,

    -- filter diagnostics
    filter_out_diagnostics_by_severity = {},
    filter_out_diagnostics_by_code = {},
  })

  -- required to fix code action ranges and filter diagnostics
  ts_utils.setup_client(client)
  -- no default maps, so you may want to define some here
  local opts = { silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>co", ":TSLspOrganize<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>cR", ":TSLspRenameFile<CR>", opts)
end

M.flags = default.lsp_flags

M.capabilities = default.capabilities

return M
