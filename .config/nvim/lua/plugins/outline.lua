return {
  {
    'hedyhli/outline.nvim',
    keys = { { '<leader>cn', '<cmd>Outline<CR>', desc = 'Outline' } },
    opts = {
      outline_window = {
        auto_close = true,
      },
      symbols = {
        filter = { 'Interface', 'Function', 'Variable', 'Component' },
      },
      symbol_folding = {
        autofold_depth = 2,
      },
      keymaps = {
        fold = { 'h', '<Left>' },
        unfold = { 'l', '<Right>' },
      },
    },
  },
}
