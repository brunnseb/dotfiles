return {
  { 'akinsho/git-conflict.nvim', event = 'BufEnter', version = '*', config = true },
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
    keys = { { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' } },
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      {
        'sindrets/diffview.nvim',
        keys = {
          { '<leader>gd', '<cmd>DiffviewOpen -uno origin/HEAD...HEAD<CR>', desc = 'Diff this' },
          { '<leader>gD', '<cmd>DiffviewOpen -uno origin/HEAD...HEAD -- %<CR>', desc = 'Diff this File' },
        },
        config = function()
          local actions = require 'diffview.actions'

          require('diffview').setup {
            diff_binaries = false,
            enhanced_diff_hl = true, -- Set up hihglights in the hooks instead
            git_cmd = { 'git' },
            hg_cmd = { 'chg' },
            use_icons = true,
            show_help_hints = false,
            icons = {
              folder_closed = '',
              folder_open = '',
            },
            signs = {
              fold_closed = '',
              fold_open = '',
            },
            view = {
              default = {
                -- layout = "diff1_inline",
                disable_diagnostics = false,
                winbar_info = false,
              },
              merge_tool = {
                layout = 'diff3_mixed',
                disable_diagnostics = true,
                winbar_info = true,
              },
              file_history = {
                -- layout = "diff1_inline",
                disable_diagnostics = false,
                winbar_info = false,
              },
            },
            file_panel = {
              listing_style = 'tree',
              tree_options = {
                flatten_dirs = true,
                folder_statuses = 'only_folded',
              },
              win_config = function()
                local editor_width = vim.o.columns
                return {
                  position = 'left',
                  width = editor_width >= 247 and 45 or 35,
                }
              end,
            },
            file_history_panel = {
              log_options = {
                git = {
                  single_file = {
                    diff_merges = 'first-parent',
                    follow = true,
                  },
                  multi_file = {
                    diff_merges = 'first-parent',
                  },
                },
              },
              win_config = {
                position = 'bottom',
                height = 8,
              },
            },
            default_args = {
              DiffviewOpen = {},
              DiffviewFileHistory = {},
            },
            hooks = {
              diff_buf_read = function()
                vim.opt_local.wrap = false

                vim.api.nvim_create_autocmd('BufEnter', {
                  desc = 'Keep winhl',
                  group = vim.api.nvim_create_augroup('winhl', { clear = true }),
                  callback = function()
                    vim.cmd [[set winhl+=]]
                  end,
                })
              end,
              ---@diagnostic disable-next-line: unused-local
              diff_buf_win_enter = function(bufnr, winid, ctx)
                -- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on
                -- the right.
                if ctx.layout_name:match '^diff2' then
                  if ctx.symbol == 'a' then
                    vim.opt_local.winhl = table.concat({
                      'DiffAdd:DiffviewDiffAddAsDelete',
                      'DiffDelete:DiffviewDiffDelete',
                      'DiffChange:DiffAddAsDelete',
                      'DiffText:DiffDeleteText',
                    }, ',')
                  elseif ctx.symbol == 'b' then
                    vim.opt_local.winhl = table.concat({
                      'DiffDelete:DiffviewDiffDelete',
                      'DiffChange:DiffAdd',
                      'DiffText:DiffAddText',
                    }, ',')
                  end
                end
              end,
            },
            keymaps = {
              view = {
                { 'n', '-', actions.toggle_stage_entry, { desc = 'Stage / unstage the selected entry' } },
                { 'n', 'q', actions.close, { desc = 'Close' } },
              },
              file_panel = {
                { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close' } },
                { 'n', '<cr>', actions.focus_entry, { desc = 'Focus the selected entry' } },
                { 'n', 's', actions.toggle_stage_entry, { desc = 'Stage / unstage the selected entry' } },
                { 'n', 'cc', '<Cmd>Git commit <bar> wincmd J<CR>', { desc = 'Commit staged changes' } },
                { 'n', 'ca', '<Cmd>Git commit --amend <bar> wincmd J<CR>', { desc = 'Amend the last commit' } },
                { 'n', 'c<space>', ':Git commit ', { desc = 'Populate command line with ":Git commit "' } },
                { 'n', 'rr', '<Cmd>Git rebase --continue <bar> wincmd J<CR>', { desc = 'Continue the current rebase' } },
                { 'n', 're', '<Cmd>Git rebase --edit-todo <bar> wincmd J<CR>', { desc = 'Edit the current rebase todo list.' } },
                {
                  'n',
                  '[c',
                  actions.view_windo(function(_, sym)
                    if sym == 'b' then
                      vim.cmd 'norm! [c'
                    end
                  end),
                },
                {
                  'n',
                  ']c',
                  actions.view_windo(function(_, sym)
                    if sym == 'b' then
                      vim.cmd 'norm! ]c'
                    end
                  end),
                },
                {
                  'n',
                  'do',
                  actions.view_windo(function(_, sym)
                    if sym == 'b' then
                      vim.cmd 'norm! do'
                    end
                  end),
                },
                {
                  'n',
                  'dp',
                  actions.view_windo(function(_, sym)
                    if sym == 'b' then
                      vim.cmd 'norm! dp'
                    end
                  end),
                },
              },
              file_history_panel = {
                { 'n', '<cr>', actions.focus_entry, { desc = 'Focus the selected entry' } },
                { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close' } },
              },
            },
          }
        end,
      },
      'ibhagwan/fzf-lua',
    },
    opts = {},
  },
}
