return {
  {
    "stevearc/overseer.nvim",
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      overseer.load_template("suisa")

      overseer.add_template_hook({
        dir = {
          vim.fn.expand("$HOME/Development/SUISA/cockpit/"),
          vim.fn.expand("$HOME/Development/SUISA/cockpit/libs/cockpit-core/"),
          vim.fn.expand("$HOME/Development/SUISA/cockpit/libs/cockpit-widgets"),
          vim.fn.expand("$HOME/Development/SUISA/ipi"),
          vim.fn.expand("$HOME/Development/SUISA/ipi/libs/ipi-core"),
          vim.fn.expand("$HOME/Development/SUISA/ipi/libs/ipi-master-domain"),
        },
        module = "^npm$",
      }, function(task_defn, _)
        task_defn.cmd = "pnpm"
      end)
    end,
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T" },
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>uC", false },
    },
  },
}
