vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic Error messages' })

vim.keymap.set('n', '<leader>xo', '<cmd>cope<CR>', { desc = '[O]pen Quickfix' })
vim.keymap.set('n', '[q', function()
  if vim.bo.filetype == 'qf' then
    vim.cmd 'colder'
  end
end, { desc = 'Go to previous [Q]uickfix' })
vim.keymap.set('n', ']q', function()
  if vim.bo.filetype == 'qf' then
    vim.cmd 'cnext'
  end
end, { desc = 'Go to next [Q]uickfix' })

vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
-- Disable macro recording and use nvim-recorder instead
vim.keymap.set({ 'x', 'n', 's' }, 'q', '<Nop>')

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-Left>', '<cmd>wincmd h<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Right>', '<cmd>wincmd l<CR>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Down>', '<cmd>wincmd j<CR>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Up>', '<cmd>wincmd k<CR>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<S-Left>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<S-Right>', '<cmd>bnext<cr>', { desc = 'Next buffer' })

vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split window below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split window right', remap = true })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete window', remap = true })

if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  vim.keymap.set('n', '<leader>uh', function()
    local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
    if type(ih) == 'function' then
      ih()
    elseif type(ih) == 'table' and ih.enable then
      ih.enable(0, not ih.is_enabled())
    end
  end, { desc = 'Toggle Inlay Hints' })
end

-- restore the session for the current directory
vim.api.nvim_set_keymap('n', '<leader>qs', [[<cmd>lua require("persistence").load()<cr>]], { desc = 'Restore session for current dir' })

-- restore the last session
vim.api.nvim_set_keymap('n', '<leader>ql', [[<cmd>lua require("persistence").load({ last = true })<cr>]], { desc = 'Restore last session' })

-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap('n', '<leader>qd', [[<cmd>lua require("persistence").stop()<cr>]], { desc = 'Stop session persistence' })
