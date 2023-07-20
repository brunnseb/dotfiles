--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
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

  nmap('<leader>lR', '<cmd>Lspsaga rename ++project<CR>', 'Rename in project')
  nmap('<leader>lT', '<cmd>Lspsaga peek_type_definition<CR>', 'Peek type definition')
  nmap('<leader>lt', '<cmd>Lspsaga goto_type_definition<CR>', 'Go to type definition')
  nmap('<leader>la', '<cmd>Lspsaga code_action<CR>', 'Code action')
  nmap('<leader>lf', '<cmd>Lspsaga finder<CR>', 'Lsp finder')
  nmap('<leader>lD', '<cmd>Lspsaga peek_definition<CR>', 'Peek definition')
  nmap('<leader>ld', '<cmd>Lspsaga goto_definition<CR>', 'Go to definition')
  nmap('gd', '<cmd>Lspsaga goto_definition<CR>', 'Go to definition')
  -- nmap('<leader>lS', '<cmd>SymbolsOutline<CR>', 'Outline')
  nmap('<leader>lh', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Line diagnostics')
  nmap('[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous diagnostics')
  nmap(']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostics')
  nmap('K', '<cmd>Lspsaga hover_doc<CR>', 'Hover doc')

  nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  if client.name == 'vtsls' then
    nmap('<leader>lu', '<cmd>VtsExec remove_unused<CR>', 'Remove unused')
    nmap('<leader>lo', '<cmd>VtsExec organize_imports<CR>', 'Organize imports')
    nmap('<leader>ls', '<cmd>VtsExec restart_tsserver<CR>', 'Restart tsserver')
    nmap('<leader>li', '<cmd>VtsExec add_missing_imports<CR>', 'Restart tsserver')
  end
end

return on_attach
