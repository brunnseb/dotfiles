return {
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    keys = {
      -- increase width
      ['<S-Right>'] = function(win)
        win:resize('width', 50)
      end,
      -- decrease width
      ['<S-Left>'] = function(win)
        win:resize('width', -50)
      end,
      -- increase height
      ['<S-Up>'] = function(win)
        win:resize('height', 50)
      end,
      -- decrease height
      ['<S-Down>'] = function(win)
        win:resize('height', -50)
      end,
    },
    init = function()
      local edgy = require 'edgy'
      vim.opt.splitkeep = 'screen'
    end,
    opts = {
      close_when_all_hidden = true,
      bottom = {
        {
          ft = 'trouble',
          title = 'Troubles',
        },
        {
          ft = 'noice',
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ''
          end,
        },
        { ft = 'qf', title = 'QuickFix' },
        {
          ft = 'help',
          size = { height = 20 },
          -- don't open help files in edgy that we're editing
          filter = function(buf)
            return vim.bo[buf].buftype == 'help'
          end,
        },
        { title = 'Neotest Output', ft = 'neotest-output-panel', size = { height = 15 } },
      },
      left = {
        {
          ft = 'aerial',
          title = 'Symbols Outline',
        },
        { ft = 'neotest-summary' },
      },
    },
  },
}
