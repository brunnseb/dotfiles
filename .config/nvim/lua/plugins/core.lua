return {
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
