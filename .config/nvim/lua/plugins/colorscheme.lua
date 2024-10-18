return {
  { 'nvchad/volt', lazy = true },
  {
    'nvchad/ui',
    priority = 20000,
    lazy = false,
    config = function()
      require 'nvchad'
    end,
    keys = {
      { '<leader>cr', '<cmd>lua require "nvchad.lsp.renamer"()<CR>', desc = '[R]ename' },
    },
  },
  {
    'nvchad/base46',
    lazy = true,
    build = function()
      require('base46').load_all_highlights()
    end,
  },
}
