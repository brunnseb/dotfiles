return {
  {
    'uga-rosa/translate.nvim',
    keys = {
      { '<leader>rg', '<cmd>Translate de<CR>', desc = 'German', mode = 'v' },
      { '<leader>re', '<cmd>Translate en<CR>', desc = 'English', mode = 'v' },
      { '<leader>rf', '<cmd>Translate fr<CR>', desc = 'French', mode = 'v' },
    },
    opts = {
      default = {
        output = 'replace',
        parse_before = 'concat,trim,natural',
      },
    },
  },
}
