return {
  {
    'jghauser/mkdir.nvim',
  },
  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
    keys = {
      { '<leader>bd', '<cmd>Bdelete<CR>', desc = 'Delete' },
      { '<leader>bo', '<cmd>%bdelete | e # | normal `"<CR>', desc = 'Delete other' },
    },
  },
  {
    'gbprod/cutlass.nvim',
    opts = { cut_key = 'x' },
  },
  {
    'fedepujol/move.nvim',
    keys = {
      { '<C-S-Down>', ':MoveBlock(1)<CR>', mode = { 'v' }, silent = true },
      { '<C-S-Up>', ':MoveBlock(-1)<CR>', mode = { 'v' }, silent = true },
      { '<C-S-Down>', '<cmd>MoveLine 1<CR>', mode = { 'n' } },
      { '<C-S-Up>', '<cmd>MoveLine -1<CR>', mode = { 'n' } },
      { '<C-S-Right>', '<cmd>MoveWord 1<CR>', mode = { 'n' } },
      { '<C-S-Left>', '<cmd>MoveWord -1<CR>', mode = { 'n' } },
      { '<C-S-Right>', ':MoveHBlock(1)<CR>', mode = { 'v' }, silent = true },
      { '<C-S-Left>', ':MoveHBlock(-1)<CR>', mode = { 'v' }, silent = true },
    },
    opts = {
      char = {
        enable = true,
      },
      --- Config
    },
  },
  -- {
  --   'abecodes/tabout.nvim',
  --   opts = {},
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'L3MON4D3/LuaSnip',
  --
  --     {
  --       'xzbdmw/nvim-cmp',
  --       branch = 'dynamic', -- Wait until https://github.com/hrsh7th/nvim-cmp/pull/1955 is merged
  --     },
  --   },
  --   event = 'InsertCharPre',
  -- },
  {
    'gbprod/yanky.nvim',
    opts = {},
    keys = {
      {
        'p',
        '<Plug>(YankyPutAfter)',
        mode = { 'n', 'x' },
      },
      {
        'P',
        '<Plug>(YankyPutBefore)',
        mode = { 'n', 'x' },
      },
      {
        'gp',
        '<Plug>(YankyGPutAfter)',
        mode = { 'n', 'x' },
      },
      {
        'gP',
        '<Plug>(YankyGPutBefore)',
        mode = { 'n', 'x' },
      },
      {
        '[y',
        '<Plug>(YankyPreviousEntry)',
      },
      {
        ']y',
        '<Plug>(YankyNextEntry)',
      },
    },
  },
  -- {
  --   'rachartier/tiny-devicons-auto-colors.nvim',
  --   dependencies = {
  --     { 'nvim-tree/nvim-web-devicons', commit = '9154484705968658e9aab2b894d1b2a64bf9f83d' },
  --   },
  --   event = 'VeryLazy',
  --   config = function()
  --     require('tiny-devicons-auto-colors').setup()
  --   end,
  -- },
  {
    'stevearc/stickybuf.nvim',
    opts = {},
  },
  { 'tpope/vim-sleuth' },
  {
    'lambdalisue/suda.vim',
    cmd = { 'SudaWrite', 'SudaRead' },
  },
  { 'pixelastic/vim-undodir-tree', event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' } },
  {
    'chrisgrieser/nvim-recorder',
    dependencies = 'rcarriga/nvim-notify', -- optional
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      mapping = {
        startStopRecording = '<C-q>',
        switchSlot = '<C-S-q>',
      },
    },
  },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    opts = {},
  },
}
