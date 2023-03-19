return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.icons.separator = ""
      return opts
    end,
    config = function(plugin, opts)
      require "plugins.configs.which-key"(plugin, opts)
      local wk = require "which-key"

      wk.register({
        k = {
          name = " Close",
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
          name = " Find",
        },
        s = {
          name = " Search / Replace",
        },
        S = {
          name = " Session",
        },
        p = {
          name = " Packages",
        },
      }, { prefix = "<leader>" })
    end,
  },
}
