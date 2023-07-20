-- [[ Basic Keymaps ]]
local wk = require 'which-key'

wk.register({
  b = {
    name = 'Buffer',
    d = { '<cmd>bd!<CR>', 'Delete buffer' },
    b = 'List buffers',
  },
  f = {
    name = 'File/Find',
    a = { '<cmd>AdvancedNewFile<CR>', 'New File' },
    e = { '<cmd>Neotree toggle<CR>', 'Neo-tree' },
    f = { '<cmd>Telescope find_files<cr>', 'Find File' },
    n = { '<cmd>NnnPicker %:p:h<CR>', 'Nnn Picker' },
    o = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File', noremap = false },
    s = { '<cmd>update!<CR>', 'Save File' },
    w = { '<cmd>Telescope live_grep_args<CR>', 'Live Grep' },
    W = { '<cmd>lua require("telescope.builtin").grep_string()<CR>', 'Search current Word' },
  },
  g = {
    name = 'Git',
    d = { '<cmd>DiffviewOpen<CR>', 'Diff' },
    g = { '<cmd>LazyGit<CR>', 'Status' },
    l = { '<cmd>DiffviewFileHistory<CR>', 'History' },
    L = { '<cmd>DiffviewFileHistory %<CR>', 'File History' },
  },
  w = {
    name = 'Window',
    d = { '<C-w>c', 'Delete window' },
    h = { '<C-w>h', 'Go to left window' },
    j = { '<C-w>j', 'Go to bottom window' },
    k = { '<C-w>k', 'Go to top window' },
    l = { '<C-w>l', 'Go to right window' },
    o = { '<cmd>WindowsMaximize<CR>', 'Maximize current window' },
    s = { '<C-w>s', 'Split horizontal' },
    v = { '<C-w>v', 'Split vertical' },
  },
  x = {
    name = 'Trouble',
    x = { '<cmd>TroubleToggle document_diagnostics<CR>', 'Document diagnostics' },
    X = { '<cmd>TroubleToggle workspace_diagnostics<CR>', 'Workspace diagnostics' },
  },
}, { prefix = '<leader>' })

vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
vim.keymap.set('n', '<c-j>', '<Plug>(YankyCycleForward)')
vim.keymap.set('n', '<c-k>', '<Plug>(YankyCycleBackward)')
vim.keymap.set('n', '[b', '<cmd>bprev<CR>')
vim.keymap.set('n', ']b', '<cmd>bnext<CR>')
-- -- Keymaps for better default experience
-- -- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--
-- -- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--
-- -- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })
--
-- vim.keymap.set('n', '<leader>n', '<cmd>NnnPicker %:p:h<CR>', { desc = 'Nnn Picker' })
-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
--
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
