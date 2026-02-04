return {

  {
    "leonardcser/cursortab.nvim",
    -- version = "*",  -- Use latest tagged version for more stability
    build = "cd server && go build",
    enabled = false,
    config = function()
      require("cursortab").setup({
        provider = {
          type = "sweep",
          url = "http://100.64.0.4:9292",
          model = "sweep",
          max_tokens = 512,
          max_diff_history_tokens = 0,
          temperature = 0.5,
          top_k = 20,
        },
        keymaps = {
          accept = "<Tab>", -- Keymap to accept completion, or false to disable
          partial_accept = "<S-Tab>", -- Keymap to partially accept, or false to disable
          trigger = "<A-a>", -- Keymap to manually trigger completion, or false to disable
        },
      })
    end,
  },
  {
    "BlinkResearchLabs/blink-edit.nvim",
    enabled = false,
    config = function()
      require("blink-edit").setup({
        llm = {
          provider = "generic",
          backend = "openai",
          url = "http://100.64.0.4:9292",
          model = "glm-4.7-flash",
          temperature = 0.1, -- Sampling temperature (0 = deterministic)
          max_tokens = 512, -- Max tokens to generate
        },

        -- context = {
        --   enabled = true, -- Master switch for context collection
        --   lines_before = 200,
        --   lines_after = 100, -- Lines after cursor (nil = provider default)
        --   max_tokens = 2048, -- Token budget for context
        --
        --   selection = {
        --     enabled = true, -- Include visual selection in context
        --     max_lines = 50, -- Max lines from selection
        --   },
        --
        --   lsp = {
        --     enabled = true, -- Fetch LSP references for cursor symbol
        --     max_definitions = 2, -- Max definition locations
        --     max_references = 2, -- Max reference locations
        --     timeout_ms = 100, -- LSP request timeout
        --   },
        --
        --   same_file = {
        --     enabled = true, -- Include surrounding lines from same file
        --     max_lines_before = 400, -- Lines above the window
        --     max_lines_after = 400, -- Lines below the window
        --   },
        --
        --   history = {
        --     enabled = true, -- Include recent edit history
        --     max_items = 10, -- Number of history entries
        --     max_tokens = 16384, -- Token budget for history
        --     max_files = 5, -- Max files in history
        --     global = false, -- Share history across buffers
        --   },
        -- },
        --
        -- ui = {
        --   progress = true, -- Show "thinking..." indicator
        --   suppress_lsp_floats = true, -- Hide LSP floats while prediction visible
        -- },
        --
        -- prefetch = {
        --   enabled = true, -- Speculative prefetch (uses extra tokens)
        --   strategy = "n-1", -- Prefetch when one hunk remains
        -- },
        --
        -- normal_mode = {
        --   enabled = true, -- Trigger predictions on idle in normal mode
        -- },
      })
    end,
  },
}
