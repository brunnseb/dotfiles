return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter', --
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'marilari88/neotest-vitest',
    },
    keys = {
      { '<leader>tt', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = 'Run test file' },
      { '<leader>tl', '<cmd>lua require("neotest").run.run()<CR>', desc = 'Run last test' },
      { '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<CR>', desc = 'Open test summary' },
      { '<leader>to', '<cmd>lua require("neotest").output_panel.toggle()<CR>', desc = 'Open output panel' },
      { '<leader>tw', '<cmd>lua require("neotest").watch.toggle(vim.fn.expand("%"))<CR>', desc = 'Open output panel' },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('neotest').setup {
        adapters = {
          require 'neotest-vitest' {
            is_test_file = function(file_path)
              if string.match(file_path, 'my-project') then
                return string.match(file_path, '/src/')
              end

              return true
            end,
          },
        },
      }
    end,
  },
}
