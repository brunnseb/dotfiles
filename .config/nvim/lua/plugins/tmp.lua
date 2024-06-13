return {
  {
    'smjonas/inc-rename.nvim',
    opts = {},
    keys = {
      { '<leader>cr', ':IncRename ', desc = 'Rename' },
    },
  },
  {
    'abecodes/tabout.nvim',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'L3MON4D3/LuaSnip',
      'hrsh7th/nvim-cmp',
    },
    event = 'InsertCharPre',
  },
}
