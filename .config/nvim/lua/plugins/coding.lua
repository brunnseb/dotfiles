return {
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      opts = {
        enable_close_on_slash = true,
      },
    },
  },
  {
    'folke/ts-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {},
  },
  { 'echasnovski/mini.pairs', version = false, event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, opts = {} },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'BufEnter',
    opts = {
      keymaps = {
        insert = '<C-g>s',
        insert_line = '<C-g>S',
        normal = 'gsr',
        normal_cur = 'gsa',
        normal_line = 'gsR',
        normal_cur_line = 'gsA',
        visual = 'S',
        visual_line = 'gS',
        delete = 'gsd',
        change = 'gsc',
        change_line = 'gsC',
      },
    },
  },
  {
    'axelvc/template-string.nvim',
    event = 'InsertEnter',
    config = true,
  },
  {
    'johmsalas/text-case.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = true,
  },
}
