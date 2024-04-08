return {
  -- lua with packer.nvim
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup {
        mapping = { 'jk', 'ne' },
      }
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
  {
    'chrisgrieser/nvim-recorder',
    dependencies = 'rcarriga/nvim-notify', -- optional
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
