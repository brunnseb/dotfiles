return {
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    init = function()
      vim.opt.splitkeep = 'screen'
    end,
    opts = {
      keys = {
        -- increase width
        ['<s-right>'] = function(win)
          win:resize('width', 100)
        end,
        -- decrease width
        ['<s-left>'] = function(win)
          win:resize('width', -100)
        end,
        -- increase height
        ['<s-up>'] = function(win)
          win:resize('height', 100)
        end,
        -- decrease height
        ['<s-down>'] = function(win)
          win:resize('height', -100)
        end,
      },
      exit_when_last = false,
      animate = {
        enabled = false,
      },
      wo = {
        winbar = true,
        winfixwidth = true,
        winfixheight = false,
        winhighlight = 'WinBar:EdgyWinBar,Normal:EdgyNormal',
        spell = false,
        signcolumn = 'no',
      },
      right = {
        {
          title = 'OGPT Popup',
          ft = 'ogpt-popup',
          size = { width = 0.2 },
          wo = {
            wrap = true,
          },
        },
        {
          title = 'OGPT Parameters',
          ft = 'ogpt-parameters-window',
          size = { height = 6 },
          wo = {
            wrap = true,
          },
        },
        {
          title = 'OGPT Template',
          ft = 'ogpt-template',
          size = { height = 6 },
        },
        {
          title = 'OGPT Sessions',
          ft = 'ogpt-sessions',
          size = { height = 6 },
          wo = {
            wrap = true,
          },
        },
        {
          title = 'OGPT System Input',
          ft = 'ogpt-system-window',
          size = { height = 6 },
        },
        {
          title = 'OGPT',
          ft = 'ogpt-window',
          size = { height = 0.5 },
          wo = {
            wrap = true,
          },
        },
        {
          title = 'OGPT {{{selection}}}',
          ft = 'ogpt-selection',
          size = { width = 80, height = 4 },
          wo = {
            wrap = true,
          },
        },
        {
          title = 'OGPt {{{instruction}}}',
          ft = 'ogpt-instruction',
          size = { width = 80, height = 4 },
          wo = {
            wrap = true,
          },
        },
        {
          title = 'OGPT Chat',
          ft = 'ogpt-input',
          size = { width = 80, height = 4 },
          wo = {
            wrap = true,
          },
        },
      },
      bottom = {
        {
          ft = 'trouble',
          title = 'Trouble',
        },
        {
          ft = 'noice',
          title = 'Noice',
          size = { height = 0.4 },
          filter = function(_, win)
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
  {
    'echasnovski/mini.animate',
    recommended = true,
    event = 'VeryLazy',
    opts = function()
      local animate = require 'mini.animate'
      return {
        resize = {
          timing = animate.gen_timing.linear { duration = 50, unit = 'total' },
        },
        cursor = {
          enable = false,
        },
      }
    end,
  },
}
