return {
  -- {
  --   'windwp/nvim-autopairs',
  --   -- Optional dependency
  --   dependencies = { 'hrsh7th/nvim-cmp' },
  --   config = function()
  --     require('nvim-autopairs').setup {}
  --     -- If you want to automatically add `(` after selecting a function or method
  --     local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  --     local cmp = require 'cmp'
  --     cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  --   end,
  -- },
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
