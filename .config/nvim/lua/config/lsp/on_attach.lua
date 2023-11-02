--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc, opt)
    if desc then
      desc = 'LSP: ' .. desc
    end
    local opts = { buffer = bufnr, desc = desc }
    if opt then
      opts = vim.tbl_deep_extend('force', opts, opt)
    end
    vim.keymap.set('n', keys, func, opts)
  end

  if client.supports_method 'textDocument/inlayHint' then
    if vim.b.inlay_hints_enabled == nil then
      vim.b.inlay_hints_enabled = vim.g.inlay_hints_enabled
    end
    if vim.b.inlay_hints_enabled then
      vim.lsp.inlay_hint(bufnr, true)
    end
    nmap('<leader>uh', function()
      vim.b.inlay_hints_enabled = not vim.b.inlay_hints_enabled
      vim.lsp.inlay_hint(bufnr or 0, vim.b.inlay_hints_enabled)
      vim.notify(string.format('Inlay hints %s', vim.b.inlay_hints_enabled and 'on' or 'off'), 'INFO')
    end, 'Toggle LSP inlay hints (buffer)')
  end

  nmap('<leader>lr', function()
    return ':IncRename ' .. vim.fn.expand '<cword>'
  end, 'Rename', { expr = true })
  nmap('<leader>lt', '<cmd>Glance type_definitions<CR>', 'Go to type definition')
  nmap('<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code action')
  nmap('<leader>lf', '<cmd>Glance references<CR>', 'Lsp finder')
  nmap('<leader>ld', '<cmd>Glance definitions<CR>', 'Go to definition')
  nmap('gd', '<cmd>Glance definitions<CR>', 'Go to definition')
  nmap('<leader>lh', '<cmd>lua vim.diagnostic.open_float({scope="line"})<CR>', 'Line diagnostics')
  nmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Previous diagnostics')
  nmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', 'Next diagnostics')
  nmap('<leader>lR', '<cmd>lua require("refactoring").select_refactor()<CR>', 'Refactor')
  vim.keymap.set(
    'v',
    '<leader>lR',
    '<cmd>lua require("refactoring").select_refactor()<CR>',
    { buffer = bufnr, desc = 'Refactor' }
  )

  nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  if client.name == 'typescript-tools' then
    nmap('<leader>lu', '<cmd>TSToolsRemoveUnused<CR>', 'Remove unused')
    nmap('<leader>lo', '<cmd>TSToolsOrganizeImports<CR>', 'Organize imports')
    nmap('<leader>li', '<cmd>TSToolsAddMissingImports<CR>', 'Add missing imports')
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

return on_attach
