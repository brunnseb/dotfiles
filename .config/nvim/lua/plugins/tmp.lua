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
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "BlinkResearchLabs/blink-edit.nvim",
    enabled = false,
    config = function()
      require("blink-edit").setup({
        llm = {
          provider = "zeta",
          backend = "openai",
          url = "http://100.64.0.4:9292",
          model = "zeta",
          temperature = 0.4, -- Sampling temperature (0 = deterministic)
          max_tokens = 2048, -- Max tokens to generate
        },

        context = {
          enabled = true, -- Master switch for context collection
          lines_before = nil, -- Lines before cursor (nil = provider default)
          lines_after = nil, -- Lines after cursor (nil = provider default)
          max_tokens = 2048, -- Token budget for context

          selection = {
            enabled = true, -- Include visual selection in context
            max_lines = 50, -- Max lines from selection
          },

          lsp = {
            enabled = true, -- Fetch LSP references for cursor symbol
            max_definitions = 2, -- Max definition locations
            max_references = 2, -- Max reference locations
            timeout_ms = 100, -- LSP request timeout
          },

          same_file = {
            enabled = true, -- Include surrounding lines from same file
            max_lines_before = 400, -- Lines above the window
            max_lines_after = 400, -- Lines below the window
          },

          history = {
            enabled = true, -- Include recent edit history
            max_items = 10, -- Number of history entries
            max_tokens = 2048, -- Token budget for history
            max_files = 5, -- Max files in history
            global = true, -- Share history across buffers
          },
        },

        ui = {
          progress = true, -- Show "thinking..." indicator
          suppress_lsp_floats = true, -- Hide LSP floats while prediction visible
        },

        prefetch = {
          enabled = false, -- Speculative prefetch (uses extra tokens)
          strategy = "n-1", -- Prefetch when one hunk remains
        },

        normal_mode = {
          enabled = false, -- Trigger predictions on idle in normal mode
        },

        accept_key = "<C-p>", -- Key to accept prediction
        reject_key = "<Esc>",
      })
    end,
  },
}
