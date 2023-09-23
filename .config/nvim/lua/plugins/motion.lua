return {
  {
    'toppair/reach.nvim',
    event = 'VeryLazy',
    config = function()
      -- default
      require('reach').setup()
      local options = {
        auto_handles = {
          'a',
          's',
          'd',
          'f',
          'j',
          'k',
          'l',
          ';',
          'g',
          'h',
          'q',
          'w',
          'e',
          'r',
          'y',
          'u',
          'i',
          'o',
          'p',
          'z',
          'x',
          'c',
          'v',
          'n',
          'm',
          ',',
        },
      }
      vim.keymap.set('n', '<leader>bb', function()
        require('reach').buffers(options)
      end, {})
      vim.keymap.set('n', "<leader>'", function()
        require('reach').marks(options)
      end, {})

      vim.keymap.set('n', '<leader>tt', function()
        require('reach').tabpages(options)
      end, {})
    end,
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
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
        'M',
        mode = { 'n', 'o', 'x' },
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
        desc = 'Flash Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
}
