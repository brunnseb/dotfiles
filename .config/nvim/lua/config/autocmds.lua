-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Inline Fold
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
--   pattern = { '*.html', '*.tsx' },
--   callback = function(_)
--     if not require('inline-fold.module').isHidden then
--       vim.cmd 'InlineFoldToggle'
--     end
--   end,
-- })

-- Barbecue
vim.api.nvim_create_autocmd({
  'WinScrolled', -- or WinResized on NVIM-v0.9 and higher
  'BufWinEnter',
  'CursorHold',
  'InsertLeave',

  -- include this if you have set `show_modified` to `true`
  'BufModifiedSet',
}, {
  group = vim.api.nvim_create_augroup('barbecue.updater', {}),
  callback = function()
    require('barbecue.ui').update()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('q_close', {}),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'AlphaReady',
  command = 'set laststatus=0',
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  command = 'set laststatus=2',
})
