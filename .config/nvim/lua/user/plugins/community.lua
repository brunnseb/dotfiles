return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- Colorschemes
  { import = "astrocommunity.colorscheme.tokyonight" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    -- further customize the options set by the community
    "catppuccin",
    config = function()
      local util = require "catppuccin.utils.colors"

      require("catppuccin").setup {
        flavour = "macchiato", -- mocha, macchiato, frappe, latte
        integrations = {
          mini = true,
          leap = true,
          markdown = true,
          overseer = true,
          lsp_trouble = true,
          ts_rainbow2 = true,
          gitsigns = true,
          hop = true,
          mason = true,
          neotree = true,
          neotest = true,
          noice = true,
          cmp = true,
          notify = true,
          treesitter_context = true,
          treesitter = true,
          symbols_outline = true,
          ts_rainbow = true,
          which_key = false,
          telescope = false,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
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
              ["@include"] = { fg = macchiato.yellow },
              ["@keyword"] = { fg = macchiato.yellow },
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
              ["@tag.attribute.tsx"] = { fg = macchiato.yellow, style = { "italic" } },
              ["@tag.delimiter.tsx"] = { fg = macchiato.pink },
              -- TS
              ["@constructor.ts"] = { fg = macchiato.teal },
              -- JSON
              ["@label.json"] = { fg = macchiato.yellow },
              -- Core
              Comment = { fg = macchiato.blue, style = { "italic" } },
              Cursor = { fg = macchiato.text, bg = macchiato.pink }, -- character under the cursor
              CursorLine = { bg = util.darken(macchiato.base, 0.8) },
              Visual = { bg = macchiato.sapphire, fg = macchiato.crust, style = { "bold" } },
              LineNr = { fg = macchiato.overlay0 },
              Pmenu = { bg = macchiato.mantle, fg = macchiato.text },
              PmenuSel = { fg = macchiato.text, bg = macchiato.pink, style = { "bold" } },
              Search = {
                bg = util.darken(macchiato.yellow, 0.5),
                fg = macchiato.text,
                style = { "bold" },
              }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand oucp.
              VertSplit = { fg = macchiato.teal },
              Folded = { bg = util.darken(macchiato.base, 0.9) },
              -- Neotree
              NeoTreeNormal = { fg = macchiato.text, bg = util.darken(macchiato.base, 0.8) },
              NeoTreeNormalNC = { fg = macchiato.text, bg = util.darken(macchiato.base, 0.8) },
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
            }
          end,
        },
        color_overrides = {
          macchiato = {
            rosewater = "#dc8a78",
            flamingo = "#DD7878",
            pink = "#FF6CA4",
            mauve = "#7F6ABE",
            red = "#D45A7E",
            maroon = "#E64553",
            peach = "#FF9D03",
            yellow = "#FFD701",
            green = "#97EA88",
            teal = "#00C8A0",
            sky = "#90EBED",
            sapphire = "#84DCC6",
            blue = "#0088FF",
            lavender = "#006dcc",
            text = "#E2EFFE",
            subtext1 = "#5B6268",
            subtext0 = "#DFDFDF",
            overlay0 = "#7C7F93",
            overlay1 = "#8C8FA1",
            overlay2 = "#9CA0B0",
            surface0 = "#ACB0BE",
            surface1 = "#BCC0CC",
            surface2 = "#CCD0DA",
            crust = "#1B2229",
            mantle = "#1A3549",
            base = "#21425b",
          },
        },
        styles = {
          keywords = { "italic" },
          booleans = { "italic" },
        },
      }
      -- vim.api.nvim_command("colorscheme catppuccin-macchiato")
    end,
  },
  -- Language packs
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.yaml" },
  -- Utility
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.lsp.progress = {
        enabled = false,
      }

      return opts
    end,
  },
  -- Debugging
  { import = "astrocommunity.debugging.nvim-bqf" },
  -- Diagnostics
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- Editor
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  -- File explorer
  { import = "astrocommunity.file-explorer.oil-nvim" },
  -- Markdown
  { import = "astrocommunity.markdown-and-latex.glow-nvim" },
  -- Motion
  { import = "astrocommunity.motion.mini-ai" },
  -- { import = "astrocommunity.motion.mini-basics" },
  { import = "astrocommunity.motion.mini-bracketed" },
  -- Project
  { import = "astrocommunity.project.neoconf-nvim" },
  { import = "astrocommunity.project.nvim-spectre" },
  -- Syntax
  { import = "astrocommunity.syntax.hlargs-nvim" },
  -- Test
  { import = "astrocommunity.test.neotest" },
}
