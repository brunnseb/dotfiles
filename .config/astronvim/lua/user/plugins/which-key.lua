return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.icons = {
        separator = "",
        group = "",
      }
      opts.plugins.presets.operators = true

      return opts
    end,
    config = function(plugin, opts)
      local wk = require "which-key"
      require "plugins.configs.which-key"(plugin, opts)

      wk.register({
        k = {
          name = " Close",
        },
        w = {
          name = " Windows", -- optional group name
        },
        u = {
          name = " UI",
        },
        x = {
          name = " Trouble",
        },
        b = {
          name = " Buffers",
        },
        f = {
          name = "󰍉 Find",
        },
        s = {
          name = " Search/Replace",
        },
        S = {
          name = " Session",
        },
        p = {
          name = " Packages",
        },
        t = {
          name = "󰙨Test",
        },
        c = {
          name = " Terminal",
        },
        d = {
          name = " Debug",
        },
      }, { prefix = "<leader>" })
    end,
  },
}
