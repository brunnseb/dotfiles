return {
  {
    'chrisgrieser/nvim-chainsaw',
    keys = {
      { '<leader>lv', '<cmd>lua require("chainsaw").variableLog()<CR>', desc = '[L]og [V]ariable' },
      { '<leader>lt', '<cmd>lua require("chainsaw").typeLog()<CR>', desc = '[L]og [T]ype' },
      { '<leader>la', '<cmd>lua require("chainsaw").assertLog()<CR>', desc = '[L]og [A]ssertion' },
      { '<leader>le', '<cmd>lua require("chainsaw").emojiLog()<CR>', desc = '[L]og [E]moji' },
      { '<leader>lm', '<cmd>lua require("chainsaw").messageLog()<CR>', desc = '[L]og [M]essage' },
      { '<leader>ld', '<cmd>lua require("chainsaw").debugLog()<CR>', desc = '[L]og [D]ebug' },
      { '<leader>lT', '<cmd>lua require("chainsaw").timeLog()<CR>', desc = '[L]og [T]ime' },
      { '<leader>ls', '<cmd>lua require("chainsaw").stacktraceLog()<CR>', desc = '[L]og [S]tacktrace' },
      { '<leader>lr', '<cmd>lua require("chainsaw").removeLogs()<CR>', desc = '[R]emove [L]ogs' },
    },
  },
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
    dependencies = { 'stevearc/dressing.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {
      snippetDir = vim.fn.stdpath 'config' .. '/snippets',
    },
  },
}
