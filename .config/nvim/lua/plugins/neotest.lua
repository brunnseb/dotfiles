return {
  {
    "nvim-neotest/neotest",
    commit = "52fca6717ef972113ddd6ca223e30ad0abb2800c",
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
