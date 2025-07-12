return {
  "nvim-neotest/neotest",
  dependencies = {
    { "marilari88/neotest-vitest" },
  },
  opts = function(_, opts)
    opts.adapters = {
      require "neotest-vitest" {},
    }

    return opts
  end,
}
