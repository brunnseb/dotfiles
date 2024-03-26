return {
  {
    'stevearc/aerial.nvim',
    keys = {
      { '<leader>cn', '<cmd>AerialNavToggle<CR>', desc = 'Toggle Navigation' },
      { '<leader>cO', '<cmd>AerialOpen<CR>', desc = 'Open Overview' },
    },
    opts = {
      keymaps = {
        ['<Left>'] = 'actions.tree_open',
        ['<S-Left>'] = 'actions.tree_open_recursive',
        ['<Right>'] = 'actions.tree_close',
        ['<S-Right>'] = 'actions.tree_close_recursive',
      },
      autojump = true,
      icons = {
        Struct = ' ',
      },
      show_guides = true,
      filter_kind = false,
      nav = {
        keymaps = {
          ['<Left>'] = 'actions.left',
          ['<Right>'] = 'actions.right',
          ['q'] = 'actions.close',
        },
        preview = true,
      },
      on_first_symbols = function(bufnr)
        require('aerial').tree_set_collapse_level(bufnr, 2)
      end,
    },
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
