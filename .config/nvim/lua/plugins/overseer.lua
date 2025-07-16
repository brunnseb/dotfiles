return {
  {
    "stevearc/overseer.nvim",
    config = function(_, opts)
      local overseer = require "overseer"
      overseer.setup(opts)

      overseer.load_template "suisa"

      overseer.add_template_hook({
        dir = {
          -- vim.fn.expand "$HOME/Development/SUISA/cockpit/apps/cockpit/",
          -- vim.fn.expand "$HOME/Development/SUISA/cockpit/apps/outlook-plugin/",
          -- vim.fn.expand "$HOME/Development/SUISA/cockpit/libs/cockpit-core/",
          -- vim.fn.expand "$HOME/Development/SUISA/cockpit/libs/cockpit-widgets",
        },
        module = "^npm$",
      }, function(task_defn, _)
        task_defn.cmd = "pnpm"
        task_defn.cwd = vim.fn.expand "$HOME/Development/SUISA/cockpit/"
      end)
    end,
  },
}
