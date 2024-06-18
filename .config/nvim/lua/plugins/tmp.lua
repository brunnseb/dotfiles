return {
  -- Simple, minimal Lazy.nvim configuration
  {
    'huynle/ogpt.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>on',
        function()
          require('lazy').reload { plugins = { 'ogpt.nvim' } }
          vim.cmd [[OGPT]]
        end,
        desc = 'New chat',
      },
    },
    opts = {
      default_provider = 'ollama',
      edgy = true, -- enable this!
      single_window = false, -- set this to true if you want only one OGPT window to appear at a time
      providers = {
        ollama = {
          api_host = 'http://media:7869',
          model = 'code-seeker:6.7b',
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  { 'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' }, keys = {
    { '<leader>bd', '<cmd>Bdelete<CR>', desc = 'Delete' },
  } },
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
}
