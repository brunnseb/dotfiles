return {
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
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
    event = 'VeryLazy',
    config = true,
  },
  {
    'axelvc/template-string.nvim',
    event = 'BufEnter',
    config = true,
  },
  {
    'johmsalas/text-case.nvim',
    event = 'BufEnter',
    config = true,
  },
}
