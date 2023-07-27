-- [[ Basic Keymaps ]]
local wk = require 'which-key'

wk.register({
  [','] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 0.25 }}))<CR>",
    'Open buffers',
  },
  ['.'] = {
    "<cmd>lua require('telescope.builtin').find_files( require('telescope.themes').get_ivy({ cwd = vim.fn.expand('%:p:h'), layout_config = { height = 0.25 }, previewer = false }))<CR>",
    'Files in current directory',
  },
  ["'"] = '  Marks',
  b = {
    name = '  Buffers',
    d = { '<cmd>bd!<CR>', 'Delete buffer' },
    b = 'List buffers',
  },
  c = {
    name = '󱙺  ChatGPT',
    c = { '<cmd>ChatGPTCompleteCode<CR>', 'Complete Code' },
    g = { '<cmd>ChatGPT<CR>', 'ChatGPT' },
    r = { '<cmd>ChatGPTRun<CR>', 'Run' },
    a = { '<cmd>ChatGPTActAs<CR>', 'Act as' },
    e = { '<cmd>ChatGPTEditWithInstructions<CR>', 'Edit with instructions' },
  },
  d = '  Debug',
  f = {
    name = '󰍉  Find/Files',
    a = { '<cmd>AdvancedNewFile<CR>', 'New File' },
    c = { '<cmd>lua require("telescope.builtin").find_files({cwd = "~/.config/nvim"})<CR>', 'Nvim config' },
    e = { '<cmd>Neotree toggle<CR>', 'Neo-tree' },
    f = {
      function()
        vim.fn.system 'git rev-parse --is-inside-work-tree'
        if vim.v.shell_error == 0 then
          require('telescope.builtin').git_files()
        else
          require('telescope.builtin').find_files()
        end
      end,
      'Find File',
    },
    n = { '<cmd>NnnPicker %:p:h<CR>', 'Nnn Picker' },
    o = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File', noremap = false },
    s = { '<cmd>update!<CR>', 'Save File' },
    w = { '<cmd>Telescope live_grep_args<CR>', 'Live Grep' },
    W = { '<cmd>lua require("telescope.builtin").grep_string()<CR>', 'Search current Word' },
  },
  g = {
    name = '  Git',
    d = { '<cmd>DiffviewOpen<CR>', 'Diff' },
    g = { '<cmd>LazyGit<CR>', 'Status' },
    l = { '<cmd>DiffviewFileHistory<CR>', 'History' },
    L = { '<cmd>DiffviewFileHistory %<CR>', 'File History' },
  },
  k = {
    name = '  Kill',
    c = { '<cmd>DeleteDebugPrints<CR>', 'Kill debug prints' },
    n = { '<cmd>lua require("notify").dismiss()<CR>', 'Kill notifications' },
  },
  l = {
    name = '  LSP',
    w = '  Workspace',
  },
  t = {
    name = '󰙨  Test',

    t = { "<cmd>lua require('neotest').run.run()<CR>", 'Run test' },
    l = { "<cmd>lua require('neotest').run.run_last()<CR>", 'Run last test' },
    f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", 'Run all tests in file' },
    s = { "<cmd>lua require('neotest').summary.toggle()<CR>", 'Toggle test summary' },
    S = { "<cmd>lua require('neotest').run.stop()<CR>", 'Stop test execution' },
    o = {
      "<cmd>lua require('neotest').output.open({enter = true, auto_close = true})<CR>",
      'Show test output',
    },
    O = { "<cmd>lua require('neotest').output_panel.toggle()<CR>", 'Toggle test output panel' },
    [']'] = {
      "<cmd>lua require('neotest').jump.next({status = 'failed'})<CR>",
      'Jump to next failed test',
    },
  },
  s = {
    name = 'Spectre',
    s = { '<cmd>lua require("spectre").open()<CR>', 'Spectre' },
    w = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', 'Search current word' },
    p = { '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', 'Search in current file' },
  },
  u = {
    name = '  UI',
    n = { '<cmd>set number! norelativenumber<CR>', 'Toggle line numbers' },
    i = { '<cmd>IndentBlanklineToggle<CR>', 'Toggle indent blankline' },
  },
  w = {
    name = '  Windows',
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
    name = '  Trouble',
    t = { '<cmd>TodoTrouble<CR>', 'Workspace todos' },
    x = { '<cmd>TroubleToggle document_diagnostics<CR>', 'Document diagnostics' },
    X = { '<cmd>TroubleToggle workspace_diagnostics<CR>', 'Workspace diagnostics' },
  },
}, { prefix = '<leader>' })

vim.keymap.set({ 'n', 'x' }, 'gj', '*')
vim.keymap.set({ 'n', 'x' }, 'gk', '#')
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
vim.keymap.set('n', '<c-j>', '<Plug>(YankyCycleForward)')
vim.keymap.set('n', '<c-k>', '<Plug>(YankyCycleBackward)')
vim.keymap.set('n', '[b', '<cmd>bprev<CR>')
vim.keymap.set('n', ']b', '<cmd>bnext<CR>')
vim.keymap.set({ 'n', 'x' }, '>', '>gv')
vim.keymap.set({ 'n', 'x' }, '<', '<gv')
vim.keymap.set('n', 'zm', '<cmd>lua require("ufo").closeFoldsWith(2)<CR>') -- closeAllFolds == closeFoldsWith(0)

vim.cmd 'map L $'
vim.cmd 'map H ^'
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
