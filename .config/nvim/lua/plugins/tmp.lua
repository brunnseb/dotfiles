return {
  {
    'jackMort/tide.nvim',
    config = function()
      require('tide').setup {
        -- optional configuration
      }
    end,
    requires = {
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'chrisgrieser/nvim-scissors',
    dependencies = { 'stevearc/dressing.nvim', 'ibhagwan/fzf-lua', 'garymjr/nvim-snippets' },
    opts = {
      snippetDir = vim.fn.stdpath 'config' .. '/snippets',
    },
  },
}
