return {
  {
    'nvim-neotest/neotest',
    event = 'LspAttach',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter', --
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      'antoinemadec/FixCursorHold.nvim',
      { 'marilari88/neotest-vitest' },
    },
    keys = {
      { '<leader>tt', '<cmd>lua require("neotest").run.run(vim.fn.expand("%:p"))<CR>', desc = 'Run test file' },
      { '<leader>tl', '<cmd>lua require("neotest").run.run()<CR>', desc = 'Run last test' },
      { '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<CR>', desc = 'Open test summary' },
      { '<leader>to', '<cmd>lua require("neotest").output_panel.toggle()<CR>', desc = 'Open output panel' },
      { '<leader>tw', '<cmd>lua require("neotest").watch.toggle(vim.fn.expand("%"))<CR>', desc = 'Watch test' },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('neotest').setup {
        consumers = {
          -- overseer = require 'neotest.consumers.overseer',
        },
        adapters = {
          require 'neotest-vitest' {},
        },
      }
    end,
  },
}
