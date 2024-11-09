return {
  {
    'DreamMaoMao/yazi.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    keys = {
      { '<leader>fn', '<cmd>Yazi<CR>', desc = 'Toggle Yazi' },
    },
  },
}
