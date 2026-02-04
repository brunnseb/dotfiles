return {
  {
    "Goose97/timber.nvim",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    keys = {
      {
        "gld",
        function()
          require("timber.actions").clear_log_statements({ global = false })
        end,
        desc = "Delete log statements (buffer)",
      },

      {
        "glD",
        function()
          require("timber.actions").clear_log_statements({ global = true })
        end,
        desc = "Delete log statements (global)",
      },
    },
    config = function()
      require("timber").setup({
        log_templates = {
          default = {
            javascript = [[console.log("%log_marker %log_target:", %log_target)]],
            typescript = [[console.log("%log_marker %log_target:", %log_target)]],
            astro = [[console.log("%log_marker %log_target:", %log_target)]],
            vue = [[console.log("%log_marker %log_target:", %log_target)]],
            jsx = [[console.log("%log_marker %log_target:", %log_target)]],
            tsx = [[console.log("%log_marker %log_target:", %log_target)]],
            lua = [[print("%log_marker %log_target:", %log_target)]],
          },
          plain = {
            javascript = [[console.log("%log_marker %insert_cursor")]],
            typescript = [[console.log("%log_marker %insert_cursor")]],
            astro = [[console.log("%log_marker %insert_cursor")]],
            vue = [[console.log("%log_marker %insert_cursor")]],
            jsx = [[console.log("%log_marker %insert_cursor")]],
            tsx = [[console.log("%log_marker %insert_cursor")]],
            lua = [[print("%log_marker %insert_cursor")]],
          },
        },
        batch_log_templates = {
          default = {
            javascript = [[console.log("%log_marker",{ %repeat<"%log_target": %log_target><, > })]],
            typescript = [[console.log("%log_marker",{ %repeat<"%log_target": %log_target><, > })]],
            astro = [[console.log("%log_marker",{ %repeat<"%log_target": %log_target><, > })]],
            vue = [[console.log("%log_marker",{ %repeat<"%log_target": %log_target><, > })]],
            jsx = [[console.log("%log_marker",{ %repeat<"%log_target": %log_target><, > })]],
            tsx = [[console.log("%log_marker",{ %repeat<"%log_target": %log_target><, > })]],
          },
        },
      })
    end,
  },
}
