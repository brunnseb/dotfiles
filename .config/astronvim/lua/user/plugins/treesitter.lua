return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- ensure_installed = { "lua" },
  },
  dependencies = {
    { "nvim-treesitter/playground" },
    --   {
    --     "HiPhish/nvim-ts-rainbow2",
    --     config = function()
    --       require("nvim-treesitter.configs").setup {
    --         rainbow = {
    --           enable = true,
    --           -- Which query to use for finding delimiters
    --           query = "rainbow-parens",
    --           -- Highlight the entire buffer all at once
    --           strategy = require "ts-rainbow.strategy.global",
    --         },
    --       }
    --     end,
    --   },
  },
}
