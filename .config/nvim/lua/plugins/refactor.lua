return {
  {
    'jdrupal-dev/code-refactor.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    cmd = { 'CodeActions' },
    config = true,
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  },
}
