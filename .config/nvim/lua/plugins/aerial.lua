return {
  {
    'stevearc/aerial.nvim',
    -- dir = '/home/brunnseb/Development/aerial.nvim/',
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
        local first_element = item.name:match '^%[(.-)%,'
        if first_element then
          -- local count = 0
          -- for k, v in item.name:gmatch '([^%,]+)' do
          --   count = count + 1
          -- end
          local value, count = string.gsub(item.name, '%,', '')
          vim.notify('value ' .. value)
          item.name = '[ ' .. first_element .. ', +' .. count - 1 .. ' ]'
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
