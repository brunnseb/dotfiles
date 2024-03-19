return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      yadm = {
        enable = true,
      },
    },
  },
  {
    'NeogitOrg/neogit',
    commit = 'dab4e50be18eab8f337b908cd871ab5f4dd031d3',
    keys = { { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' } },
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
  },
}
