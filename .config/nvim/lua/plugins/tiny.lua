return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        blend = {
          factor = 0.1, -- Adjust this value to control background opacity (0.0 to 1.0)
        },
        -- signs = {
        --     -- left = "", -- Left border character
        --     -- right = "", -- Right border character
        --     -- diag = "●", -- Diagnostic indicator character
        --     -- arrow = "", -- Arrow pointing to diagnostic
        --     -- up_arrow = "    ", -- Upward arrow for multiline
        --     -- vertical = " │", -- Vertical line for multiline
        --     -- vertical_end = " └", -- End of vertical line for multiline
        -- },
        hi = {
          arrow = "TinyInlineDiagnosticVirtualTextArrow",
          error = "TinyInlineDiagnosticVirtualTextError",
          hint = "TinyInlineDiagnosticVirtualTextHint",
          info = "TinyInlineDiagnosticVirtualTextInfo",
          warn = "TinyInlineDiagnosticVirtualTextWarn",
          -- background = "None", -- Use Normal background for blending
          -- mixing_color = "None", -- Blend with Normal background
        },
        options = {
          break_line = {
            after = 40,
            enabled = false,
          },
          format = function(diagnostic)
            return diagnostic.message
          end,
          multilines = false,
          multiple_diag_under_cursor = false,
          overflow = {
            mode = "wrap",
          },
          show_source = false,
          softwrap = 15,
          throttle = 20,
          virt_texts = {
            priority = 2048,
          },
        },
        preset = "modern",
      })
      vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
    end,
  },
}
