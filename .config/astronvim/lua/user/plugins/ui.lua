return {
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      opts.top_down = false
      return opts
    end,
  },
}
