return {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, opts)
      opts.current_line_blame = true
      opts.yadm = {
        enable = true,
      }

      return opts
    end,
  },
}
