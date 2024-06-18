return {
  {
    'huynle/ogpt.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>an',
        function()
          -- Hack until https://github.com/MunifTanjim/nui.nvim/pull/367 gets resolved
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
          model = 'llama3:8b-instruct-q4_K_M',
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'abecodes/tabout.nvim',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'L3MON4D3/LuaSnip',
      'hrsh7th/nvim-cmp',
    },
    event = 'InsertCharPre',
  },
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
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    config = function()
      require('tiny-devicons-auto-colors').setup()
    end,
  },
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
    'gaelph/logsitter.nvim',
    keys = { {
      '<leader>cg',
      function()
        require('logsitter').log()
      end,
      desc = 'Log symbol',
    } },
  },
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
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    dependencies = {
      {
        'junegunn/fzf',
        run = function()
          vim.fn['fzf#install']()
        end,
      },
    },
  },
}
