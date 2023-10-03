local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'qf', 'lspinfo', 'neotest-output', 'neotest-output-panel', 'spectre_panel' },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})

local hocon_group = vim.api.nvim_create_augroup('hocon', { clear = true })
vim.api.nvim_create_autocmd(
  { 'BufNewFile', 'BufRead' },
  { group = hocon_group, pattern = '*/*.conf', command = 'set ft=hocon' }
)

-- Close LuaSnip session when changing to insert mode
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if
      ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
      and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end,
})

-- LogSitter
vim.api.nvim_create_augroup('LogSitter', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'LogSitter',
  pattern = 'javascript,javascriptreact,typescript,typescriptreact,go,lua',
  callback = function()
    vim.keymap.set('n', '<leader>lg', function()
      require('logsitter').log()
    end)
  end,
})
