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
    event = 'InsertEnter',
    config = true,
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
