return {
  {
    'uga-rosa/translate.nvim',
    keys = {
      { '<leader>rg', '<cmd>Translate de<CR>', desc = 'German', mode = 'x' },
      { '<leader>re', '<cmd>Translate en<CR>', desc = 'English', mode = 'x' },
      { '<leader>rf', '<cmd>Translate fr<CR>', desc = 'French', mode = 'x' },
    },
    opts = {
      default = {
        output = 'replace',
        parse_before = 'concat,trim,natural',
      },
    },
  },
}
