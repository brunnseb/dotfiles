return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufEnter',
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '┃' },
        topdelete = { text = '┃' },
        changedelete = { text = '┃' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', ']g', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '[g', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set(
          'n',
          '<leader>gh',
          require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = '[P]review [H]unk' }
        )
      end,
    },
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = { 'LazyGit' },
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
  { 'akinsho/git-conflict.nvim', event = 'BufEnter', version = '*', config = true },
}
