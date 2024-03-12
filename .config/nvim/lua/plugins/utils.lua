return {
  { 'tpope/vim-sleuth' },
  {
    'lambdalisue/suda.vim',
    cmd = { 'SudaWrite', 'SudaRead' },
  },
  { 'pixelastic/vim-undodir-tree' },
  {
    'gaelph/logsitter.nvim',
    event = 'BufEnter',
    keys = { {
      '<leader>cg',
      function()
        require('logsitter').log()
      end,
      desc = 'Log symbol',
    } },
  },
}
