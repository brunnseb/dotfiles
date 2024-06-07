return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      current_line_blame = true,
      yadm = {
        enable = true,
      },
    },
    config = function(_, opts)
      require('gitsigns').setup(vim.tbl_deep_extend('force', opts, {

        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          ---@diagnostic disable-next-line: redefined-local
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']h', function()
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[h', function()
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage hunk' })
          map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset hunk' })
          map('v', '<leader>gs', function()
            gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'Stage hunk' })
          map('v', '<leader>gr', function()
            gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'Reset hunk' })
          map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage buffer' })
          map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset buffer' })
          map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview hunk' })
          map('n', '<leader>gb', function()
            gs.blame_line { full = true }
          end, { desc = 'Blame line' })
          map('n', '<leader>ub', gs.toggle_current_line_blame, { desc = 'Toggle line blame' })
          map('n', '<leader>ud', gs.toggle_deleted, { desc = 'Toggle deleted' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'inner hunk' })
        end,
      }))
    end,
  },
  {
    'NeogitOrg/neogit',
    commit = 'dab4e50be18eab8f337b908cd871ab5f4dd031d3',
    keys = { { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' } },
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      {
        'sindrets/diffview.nvim',
        keys = {
          { '<leader>gd', '<cmd>DiffviewOpen origin/HEAD...HEAD<CR>', desc = 'Diff this' },
          { '<leader>gD', '<cmd>DiffviewOpen origin/HEAD...HEAD -- %<CR>', desc = 'Diff this File' },
        },
        opts = function(_, opts)
          local actions = require 'diffview.actions'
          opts.default_args = {
            DiffviewOpen = { '--imply-local' },
          }
          opts.keymaps = {
            view = {
              { 'n', 'q', actions.close, { desc = 'Close' } },
            },
            file_panel = {
              { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close' } },
            },
            file_history_panel = {
              { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close' } },
            },
          }
        end,
      },
      'ibhagwan/fzf-lua',
    },
    opts = {},
  },
}
