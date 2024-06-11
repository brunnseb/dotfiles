return {
  { 'levouh/tint.nvim', opts = {} },
  {
    'nvim-focus/focus.nvim',
    version = false,
    opts = {},
    keys = {
      { '<leader>wv', '<cmd>FocusSplitRight<CR>', desc = 'Split right' },
      { '<leader>ws', '<cmd>FocusSplitDown<CR>', desc = 'Split down' },
      { '<leader>wo', '<cmd>FocusMaximise<CR>', desc = 'Maximize' },
      { '<leader>we', '<cmd>FocusEqualise<CR>', desc = 'Equalize' },
    },
  },
}
