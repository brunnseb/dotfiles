return {
  {
    'goolord/alpha-nvim',
    config = function()
      local dashboard = require 'alpha.themes.dashboard'
      local startup_time = nil

      dashboard.section.header.val = {
        [[     █  █     ]],
        [[     ██ ██     ]],
        [[     █████     ]],
        [[     ██ ███     ]],
        [[     █  █     ]],
        [[]],
        [[N  E  O   V  I  M]],
      }
      dashboard.section.header.opts.hl = {
        { { 'NeovimDashboardLogo1', 5, 8 }, { 'NeovimDashboardLogo3', 8, 22 } },
        { { 'NeovimDashboardLogo1', 5, 7 }, { 'NeovimDashboardLogo2', 8, 10 }, { 'NeovimDashboardLogo3', 11, 24 } },
        { { 'NeovimDashboardLogo1', 5, 11 }, { 'NeovimDashboardLogo3', 11, 26 } },
        { { 'NeovimDashboardLogo1', 5, 11 }, { 'NeovimDashboardLogo3', 11, 24 } },
        { { 'NeovimDashboardLogo1', 5, 11 }, { 'NeovimDashboardLogo3', 11, 22 } },
      }
      dashboard.section.buttons.val = {}

      dashboard.section.footer.val = function()
        if not startup_time then
          return {}
        end
        local stats = require('lazy').stats()
        return { string.format('Loaded %.0f/%.0f Plugins in %.0fms', stats.loaded, stats.count, startup_time) }
      end

      local augroup = vim.api.nvim_create_augroup('alpha', {})

      vim.api.nvim_create_autocmd('User', {
        group = augroup,
        pattern = 'LazyVimStarted',
        callback = function()
          startup_time = require('lazy').stats().startuptime
          vim.cmd.AlphaRedraw()
        end,
      })

      require('alpha').setup(dashboard.config)
    end,
  },
}
