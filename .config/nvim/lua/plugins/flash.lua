return {
  {
    'folke/flash.nvim',
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        'tsn',
        mode = { 'x', 'o', 'n' },
        function()
          require('flash').jump {
            search = { wrap = false, mult_window = false, forward = true, mode = 'search', max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = '^',
          }
        end,
      },
      {
        'tse',
        mode = { 'x', 'o', 'n' },
        function()
          require('flash').jump {
            search = { wrap = false, mult_window = false, forward = false, mode = 'search', max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = '^',
          }
        end,
      },
    },
  },
}
