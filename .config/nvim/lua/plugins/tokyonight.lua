return {
  {
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      opts.style = "moon"
      opts.styles = {
        -- functions = { italic = true },
        variables = { italic = true },
        floats = "transparent",
      }

      opts.dim_inactive = true

      opts.on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.MultiCursorInsert = {
          fg = c.fg,
          bg = c.teal,
          italic = true,
          bold = true,
        }
        hl.MultiCursorExtend = { fg = c.fg, bg = c.magenta, italic = true, bold = true }
        hl.MultiCursorCursor = {
          fg = c.magenta,
          bg = c.bg,
        }
        hl.MultiCursorMono = { fg = c.fg, bg = c.magenta, italic = true, bold = true }
      end
    end,
  },
}
