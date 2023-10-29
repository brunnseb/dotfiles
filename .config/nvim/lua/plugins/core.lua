return {
  {
    'johmsalas/text-case.nvim',
    config = true,
  },
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^1.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
  },
  { 'tiagovla/scope.nvim', config = true },
  {
    'tpope/vim-sleuth',
    event = 'BufEnter',
  },
  {
    'max397574/better-escape.nvim',
    event = 'VeryLazy',
    config = true,
  },
  {
    'lambdalisue/suda.vim',
    cmd = { 'SudaWrite', 'SudaRead' },
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  },
  {
    'notjedi/nvim-rooter.lua',
    event = 'VeryLazy',
    opts = {
      rooter_patterns = {
        '=hypr',
        '=eww',
        '=astronvim',
        '=nvim',
        'turbo.json',
        -- 'package.json',
        -- '.vscode',
        -- '.git',
      },
      trigger_patterns = { '*' },
      manual = false,
    },
  },
}
