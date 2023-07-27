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

-- Overwrite Neoline colors
vim.api.nvim_create_autocmd('BufEnter', {
  command = [[
    let g:neoline_green='#00C8A0'
    let g:neoline_green_light='#696969'
    let g:neoline_blue='#0088FF'
    let g:neoline_red='#D45A7E'
    let g:neoline_purple='#FF6CA4'
    let g:neoline_purple_light='#84DCC6'
  ]],
})

local hocon_group = vim.api.nvim_create_augroup('hocon', { clear = true })
vim.api.nvim_create_autocmd(
  { 'BufNewFile', 'BufRead' },
  { group = hocon_group, pattern = '*/*.conf', command = 'set ft=hocon' }
)

-- Fix exit with error 134
-- vim.api.nvim_create_autocmd({ 'VimLeave' }, {
--   callback = function()
--     vim.cmd 'sleep 50m'
--   end,
-- })
