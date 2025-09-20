return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "marilari88/neotest-vitest" },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("neotest").setup({
        consumers = {
          -- overseer = require 'neotest.consumers.overseer',
        },
        adapters = {
          require("neotest-vitest")({}),
        },
      })
    end,
  },
}
