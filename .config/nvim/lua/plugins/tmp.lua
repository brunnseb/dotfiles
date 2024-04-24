return {
  {
    'gbprod/yanky.nvim',
    config = function()
      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

      vim.keymap.set('n', '[y', '<Plug>(YankyPreviousEntry)')
      vim.keymap.set('n', ']y', '<Plug>(YankyNextEntry)')

      require('yanky').setup {}
    end,
  },
}
