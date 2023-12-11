return {
  {
    "catppuccin/nvim",
    config = function()
      local util = require("catppuccin.utils.colors")

      local colors = require("utils.colorscheme").catppucinn_colors

      require("catppuccin").setup({
        flavour = "macchiato", -- mocha, macchiato, frappe, latte
        integrations = {
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          gitsigns = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          lsp_trouble = false,
          markdown = true,
          mason = true,
          mini = {
            enabled = true,
            indentscope_color = "teal",
          },
          dap = {
            enabled = true,
            enable_ui = true,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          rainbow_delimiters = true,
          semantic_tokens = true,
          symbols_outline = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
        highlight_overrides = {
          macchiato = function(macchiato)
            return {
              -- Treesitter
              ["@boolean"] = { fg = macchiato.pink },
              ["@constant"] = { fg = macchiato.red },
              ["@constant.builtin"] = { fg = macchiato.yellow },
              ["@constant.macro"] = { fg = macchiato.mauve },
              ["@constructor"] = { fg = macchiato.teal },
              ["@danger"] = { fg = macchiato.base, bg = macchiato.red },
              ["@field"] = { fg = macchiato.text },
              ["@field.lua"] = { fg = macchiato.text },
              ["@float"] = { fg = macchiato.pink },
              ["@function"] = { fg = macchiato.sky },
              ["@function.builtin"] = { fg = macchiato.yellow },
              ["@function.macro"] = { fg = macchiato.teal },
              ["@include"] = { fg = macchiato.yellow, style = { "italic" } },
              ["@keyword"] = { fg = macchiato.yellow, style = { "italic" } },
              ["@keyword.function"] = { fg = macchiato.mauve },
              ["@keyword.operator"] = { fg = macchiato.peach },
              ["@keyword.return"] = { fg = macchiato.pink },
              ["@label"] = { fg = macchiato.sapphire },
              ["@method"] = { fg = macchiato.text },
              ["@namespace"] = { fg = macchiato.blue },
              ["@note"] = { fg = macchiato.base, bg = macchiato.blue },
              ["@number"] = { fg = macchiato.pink },
              ["@operator"] = { fg = macchiato.green },
              ["@parameter"] = { fg = macchiato.sky },
              ["@property"] = { fg = macchiato.flamingo },
              ["@punctuation.bracket"] = { fg = macchiato.text },
              ["@punctuation.special"] = { fg = macchiato.sky },
              ["@string"] = { fg = macchiato.green },
              ["@string.escape"] = { fg = macchiato.pink },
              ["@string.regex"] = { fg = macchiato.peach },
              ["@tag"] = { fg = macchiato.teal },
              ["@tag.attribute"] = { fg = macchiato.yellow },
              ["@tag.delimiter"] = { fg = macchiato.pink },
              ["@text"] = { fg = macchiato.text },
              ["@text.emphasis"] = { fg = macchiato.maroon },
              ["@text.literal"] = { fg = macchiato.teal },
              ["@text.reference"] = { fg = macchiato.lavender },
              ["@text.strong"] = { fg = macchiato.maroon },
              ["@text.title"] = { fg = macchiato.blue },
              ["@text.uri"] = { fg = macchiato.rosewater },
              ["@type"] = { fg = macchiato.peach },
              ["@type.builtin"] = { fg = macchiato.yellow },
              ["@variable"] = { fg = macchiato.text },
              ["@variable.builtin"] = { fg = macchiato.red },
              ["@warning"] = { fg = macchiato.base, bg = macchiato.yellow },
              -- TSX
              ["@constructor.tsx"] = { fg = macchiato.teal },
              ["@tag.tsx"] = { fg = macchiato.teal },
              ["@tag.attribute.tsx"] = {
                fg = macchiato.yellow,
                style = {
                  "italic",
                },
              },
              ["@tag.delimiter.tsx"] = { fg = macchiato.pink },
              -- TS
              ["@constructor.ts"] = { fg = macchiato.teal },
              -- JSON
              ["@label.json"] = { fg = macchiato.yellow },
              -- LSP
              LspReferenceText = {
                bg = util.lighten(macchiato.base, 0.9),
                style = { "bold" },
              },
              LspReferenceWrite = {
                bg = util.lighten(macchiato.base, 0.9),
                style = { "bold" },
              },
              LspReferenceRead = {
                bg = util.lighten(macchiato.base, 0.9),
                style = { "bold" },
              },
              ["@lsp.typemod.parameter.declaration"] = { style = { "bold", "italic" } },
              ["@lsp.type.parameter"] = { fg = macchiato.pink },
              -- Core
              Comment = { fg = macchiato.blue, style = { "italic" } },
              Cursor = { fg = macchiato.text, bg = macchiato.pink }, -- character under the cursor
              CursorLine = { bg = util.darken(macchiato.base, 0.8) },
              Visual = { bg = macchiato.sapphire, fg = macchiato.crust, style = { "bold" } },
              LineNr = { fg = macchiato.overlay0 },
              MatchWord = { fg = macchiato.teal, style = { "italic", "bold" } },
              MatchParen = { fg = macchiato.teal, bg = macchiato.base, style = { "italic", "bold" } },
              MatchParenCur = { fg = macchiato.teal, bg = macchiato.base, style = { "italic", "bold" } },
              Pmenu = { bg = macchiato.mantle, fg = macchiato.text },
              PmenuSel = { fg = macchiato.text, bg = macchiato.pink, style = { "bold" } },
              Search = {
                bg = util.darken(macchiato.yellow, 0.5),
                fg = macchiato.text,
                style = { "bold" },
              }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand oucp.
              VertSplit = { fg = macchiato.teal },
              Folded = { bg = util.darken(macchiato.base, 0.9) },
              -- Indent Blankline
              IblIndent = { fg = util.lighten(macchiato.base, 0.9) },
              IblScope = { fg = macchiato.teal },
              -- Inlay Hints
              LspInlayHint = {
                fg = macchiato.surface0,
                bg = macchiato.base,
                style = { "italic" },
              },
              -- Neotree
              NeoTreeNormal = { fg = macchiato.text, bg = util.darken(macchiato.base, 0.6) },
              NeoTreeNormalNC = { fg = macchiato.text, bg = util.darken(macchiato.base, 0.6) },
              -- Telescope
              TelescopeTitle = { fg = macchiato.pink },
              TelescopeMatching = { fg = macchiato.pink },
              TelescopeBorder = {
                fg = util.darken(macchiato.base, 0.8),
                bg = util.darken(macchiato.base, 0.8),
              },
              TelescopePromptBorder = {
                fg = util.darken(macchiato.base, 0.8),
                bg = util.darken(macchiato.base, 0.8),
              },
              TelescopePromptNormal = {
                fg = macchiato.text,
                bg = util.darken(macchiato.base, 0.8),
              },
              TelescopePromptPrefix = {
                fg = macchiato.red,
                bg = util.darken(macchiato.base, 0.8),
              },
              TelescopeNormal = { bg = util.darken(macchiato.base, 0.8) },
              TelescopePreviewTitle = {
                fg = util.darken(macchiato.base, 0.8),
                bg = macchiato.teal,
                style = { "italic", "bold" },
              },
              TelescopePromptTitle = {
                fg = util.darken(macchiato.base, 0.8),
                bg = macchiato.pink,
                style = { "italic", "bold" },
              },
              TelescopeResultsTitle = {
                fg = util.darken(macchiato.base, 0.8),
                bg = util.darken(macchiato.base, 0.8),
              },
              TelescopeSelection = {
                bg = util.darken(macchiato.base, 0.8),
                fg = macchiato.flamingo,
                style = { "italic", "bold" },
              },
              TelescopeResultsDiffAdd = {
                fg = macchiato.teal,
              },
              TelescopeResultsDiffChange = {
                fg = macchiato.yellow,
              },
              TelescopeResultsDiffDelete = {
                fg = macchiato.pink,
              },
              -- Which Key
              WhichKeyBorder = {
                fg = util.darken(macchiato.base, 0.8),
                bg = util.darken(macchiato.base, 0.8),
              },
              WhichKeyFloat = {
                bg = util.darken(macchiato.base, 0.8),
                fg = macchiato.text,
              },
              WhichKey = { fg = macchiato.teal },
              WhichKeyGroup = { fg = macchiato.lavender },
              WhichKeySeparator = { fg = macchiato.yellow },
              WhichKeyDesc = { fg = macchiato.blue },
              -- Flash
              FlashLabel = { fg = macchiato.pink, style = { "italic,bold" } },
              FlashMatch = {
                bg = util.darken(macchiato.yellow, 0.5),
                fg = macchiato.text,
              },
              -- Vim Visual Multi
              MultiCursorInsert = {
                fg = macchiato.text,
                style = { "italic,bold" },
                bg = util.darken(macchiato.teal, 0.8),
              },
              MultiCursorExtend = { fg = macchiato.text, style = { "italic,bold" }, bg = macchiato.pink },
              MultiCursorCursor = {
                fg = macchiato.pink,
                style = { "italic,bold" },
                bg = util.darken(macchiato.base, 0.8),
              },
              MultiCursorMono = { fg = macchiato.text, style = { "italic,bold" }, bg = macchiato.pink },
            }
          end,
        },
        color_overrides = {
          macchiato = colors,
        },
        styles = {
          keywords = { "italic" },
          booleans = { "italic" },
        },
      })

      -- Map treesitter highlights to semantic_tokens
      local links = {
        ["@lsp.type.namespace"] = "@namespace",
        ["@lsp.type.type"] = "@type",
        ["@lsp.type.class"] = "@type",
        ["@lsp.type.enum"] = "@type",
        ["@lsp.type.interface"] = "@type",
        ["@lsp.type.struct"] = "@structure",
        ["@lsp.type.parameter"] = "@parameter",
        ["@lsp.type.variable"] = "@variable",
        ["@lsp.type.property"] = "@property",
        ["@lsp.type.enumMember"] = "@constant",
        ["@lsp.type.function"] = "@function",
        ["@lsp.type.method"] = "@method",
        ["@lsp.type.macro"] = "@macro",
        ["@lsp.type.decorator"] = "@function",
      }

      for newgroup, oldgroup in pairs(links) do
        vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
      end

      -- vim.cmd [[colorscheme catppuccin-macchiato]]
    end,
  },
}
