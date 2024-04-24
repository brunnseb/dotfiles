return {
  {
    'uga-rosa/translate.nvim',
    cmd = { 'Translate' },
    opts = {
      default = {
        output = 'replace',
        parse_before = 'concat,trim,natural',
      },
    },
  },
}
