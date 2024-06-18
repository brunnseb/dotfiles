return {
  { -- The task runner we use
    'stevearc/overseer.nvim',
    dependencies = { { 'akinsho/toggleterm.nvim', version = '*', config = true } },
    opts = {
      strategy = {
        'toggleterm',
        use_shell = true,
        auto_scroll = true,
        open_on_start = false,
      },
      task_list = {
        direction = 'left',
      },
    },
    keys = {
      { '<leader>oo', '<cmd>OverseerOpen<CR>', desc = '[O]pen' },
      { '<leader>ot', '<cmd>OverseerToggle<CR>', desc = '[T]oggle' },
      { '<leader>or', '<cmd>OverseerRun<CR>', desc = '[R]un' },
      { '<leader>oa', '<cmd>OverseerQuickAction<CR>', desc = 'Quick[A]ction' },
      {
        '<leader>ol',
        function()
          local overseer = require 'overseer'
          local bundles = overseer.list_task_bundles()
          vim.ui.select(bundles, {
            prompt = 'Select bundle to start',
          }, function(task)
            overseer.load_task_bundle(task)
          end)
        end,
        desc = '[L]ist bundles',
      },
    },
    config = function(_, opts)
      local overseer = require 'overseer'
      overseer.setup(opts)

      overseer.load_template 'suisa'

      overseer.add_template_hook({
        dir = {
          '/home/brunnseb/Development/SUISA/cockpit/',
          '/home/brunnseb/Development/SUISA/cockpit/libs/cockpit-core/',
          '/home/brunnseb/Development/SUISA/cockpit/libs/cockpit-widgets',
        },
        module = '^npm$',
      }, function(task_defn, util)
        task_defn.cmd = 'pnpm'
      end)
      -- overseer.add_template_hook({
      --   dir = { '/home/brunnseb/Development/SUISA/cockpit/libs/cockpit-core/' },
      --   name = '^Neotest$',
      -- }, function(task_defn, util)
      --   vim.notify 'neotest'
      --   -- task_defn.cmd = 'pnpm'
      -- end)
    end,
  },
}
