return {
  {
    'windwp/nvim-autopairs',
    dependencies = { 'hrsh7th/nvim-cmp' },
    event = 'InsertEnter',
    opts = {},
  },
  { 'numToStr/Comment.nvim', opts = {} },
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
