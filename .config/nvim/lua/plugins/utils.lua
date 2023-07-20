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

      vim.keymap.set('n', '<leader>wt', function()
        require('reach').tabpages(options)
      end, {})
    end,
  },
  { 'Mohammed-Taher/AdvancedNewFile.nvim' },
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
    config = function()
      vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'ge', "<cmd>lua require('spider').motion('ge')<CR>", { desc = 'Spider-ge' })
    end,
    event = 'VeryLazy',
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
