return {
  {
    'stevearc/aerial.nvim',
    keys = {
      { '<leader>cn', '<cmd>AerialNavToggle<CR>', desc = 'Toggle Navigation' },
      { '<leader>cO', '<cmd>AerialOpen<CR>', desc = 'Open Overview' },
    },
    event = { 'BufEnter' },
    opts = {
      backends = {
        ['_'] = { 'treesitter', 'lsp' },
        lua = { 'lsp' },
      },
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
      post_parse_symbol = function(bufnr, item, ctx)
        if ctx.match then
          local first = ctx.match['first']
          local second = ctx.match['second']
          local third = ctx.match['third']

          if first and second and third then
            local first_text = vim.treesitter.get_node_text(first.node, bufnr)
            local second_text = vim.treesitter.get_node_text(second.node, bufnr)
            vim.notify(item.name)

            item.name = '< ' .. first_text .. ', ' .. second_text .. ', ... >'
          end
        end
        return true
      end,
    },
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
