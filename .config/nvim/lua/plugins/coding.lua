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
  {
    'windwp/nvim-autopairs',
    dependencies = { 'hrsh7th/nvim-cmp' },
    event = 'InsertEnter',
    opts = {},
  },
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
