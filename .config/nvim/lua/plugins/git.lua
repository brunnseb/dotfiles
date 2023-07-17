return {
  {
    'kdheepak/lazygit.nvim',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    opts = {
      keymaps = {
        file_history_panel = {
          { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close' } },
        },
        file_panel = {
          { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close' } },
        },
        view = {
          { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close' } },
        },
      },
    },
  },
  { 'akinsho/git-conflict.nvim', version = '*', config = true },
}
