return {
  {
    'yioneko/nvim-vtsls',
    ft = { 'typescriptreact', 'typescript', 'javascript', 'javascriptreact' },
    config = function()
      require('vtsls').config {
        refactor_auto_rename = true,
      }
    end,
  },
}
