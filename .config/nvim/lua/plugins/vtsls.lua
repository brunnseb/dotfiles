return {
  {
    'yioneko/nvim-vtsls',
    enabled = false,
    ft = { 'typescriptreact', 'typescript', 'javascript', 'javascriptreact' },
    config = function()
      require('vtsls').config {
        refactor_auto_rename = true,
      }
    end,
  },
}
