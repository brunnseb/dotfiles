return {
  {
    "axelvc/template-string.nvim",
    event = "User AstroFile",
    config = function() require("template-string").setup {} end,
  },
  {
    "nvim-neotest/neotest",
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup {
        adapters = {
          require "neotest-vitest",
        },
      }
    end,
    dependencies = {
      "marilari88/neotest-vitest",
    },
  },
  {
    "gaelph/logsitter.nvim",
    event = "User AstroFile",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "abecodes/tabout.nvim",
    dependencies = { "nvim-treesitter" },
    event = "VeryLazy",
  },
}
