return {
  {
    'mg979/vim-visual-multi',
    event = 'BufEnter',
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
  },
  {
    'andrewferrier/debugprint.nvim',
    config = true,
    event = 'BufEnter',
  },
  {
    'windwp/nvim-autopairs',
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
    'chrisgrieser/nvim-spider',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'ge', "<cmd>lua require('spider').motion('ge')<CR>", { desc = 'Spider-ge' })
    end,
  },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'abecodes/tabout.nvim',
    dependencies = { 'nvim-treesitter' },
    event = 'VeryLazy',
  },
  {
    'axelvc/template-string.nvim',
    event = 'User AstroFile',
    config = true,
  },
  { 'gbprod/yanky.nvim', opts = {}, event = 'VeryLazy' },
}
