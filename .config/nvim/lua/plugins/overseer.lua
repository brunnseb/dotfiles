return {
  { -- The task runner we use
    'stevearc/overseer.nvim',
    opts = {
      task_list = {
        direction = 'bottom',
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
    keys = {
      { '<leader>oo', '<cmd>OverseerOpen<CR>', desc = '[O]pen' },
      { '<leader>or', '<cmd>OverseerRun<CR>', desc = '[R]un' },
      { '<leader>oa', '<cmd>OverseerQuickAction<CR>', desc = 'Quick[A]ction' },
    },
    config = function(_, opts)
      local overseer = require 'overseer'
      overseer.setup(opts)
      overseer.add_template_hook({
        dir = { '/home/brunnseb/Development/SUISA/cockpit/', '/home/brunnseb/Development/SUISA/cockpit/libs/cockpit-core/' },
        module = '^npm$',
      }, function(task_defn, util)
        task_defn.cmd = 'pnpm'
      end)
      overseer.add_template_hook({
        dir = { '/home/brunnseb/Development/SUISA/cockpit/libs/cockpit-core/' },
        name = '^Neotest$',
      }, function(task_defn, util)
        vim.notify 'neotest'
        -- task_defn.cmd = 'pnpm'
      end)
    end,
  },
}
