return {
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      opts.top_down = false
      opts.max_height = function() return math.floor(vim.o.lines * 0.3) end
      opts.max_width = function() return math.floor(vim.o.columns * 0.3) end

      return opts
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    dependencies = { "folke/twilight.nvim" },
    opts = function(_, opts)
      opts.plugins.twilight = {
        enabled = true,
      }

      return opts
    end,
  },
}
