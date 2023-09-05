local M = {}

M.setup = function()
  local util = require 'catppuccin.utils.colors'

  local colors = {
    rosewater = '#dc8a78',
    flamingo = '#DD7878',
    pink = '#FF6CA4',
    mauve = '#7F6ABE',
    red = '#D45A7E',
    maroon = '#E64553',
    peach = '#FF9D03',
    yellow = '#FFD701',
    green = '#97EA88',
    teal = '#00C8A0',
    sky = '#90EBED',
    sapphire = '#84DCC6',
    blue = '#0088fe',
    lavender = '#006dcc',
    text = '#E2EFFE',
    subtext1 = '#5B6268',
    subtext0 = '#DFDFDF',
    overlay0 = '#7C7F93',
    overlay1 = '#8C8FA1',
    overlay2 = '#9CA0B0',
    surface0 = '#ACB0BE',
    surface1 = '#BCC0CC',
    surface2 = '#CCD0DA',
    crust = '#1B2229',
    mantle = '#1A3549',
    base = '#21425b',
  }

  require('catppuccin').setup {
    flavour = 'macchiato', -- mocha, macchiato, frappe, latte
    integrations = {
      semantic_tokens = true,
      alpha = true,
      mini = true,
      markdown = true,
      lsp_trouble = false,
      rainbow_delimiters = true,
      gitsigns = true,
      mason = true,
      neotree = true,
      neotest = true,
      noice = true,
      cmp = true,
      notify = true,
      treesitter_context = true,
      treesitter = true,
      symbols_outline = true,
      which_key = true,
      -- lsp_saga = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
    },
    highlight_overrides = {
      macchiato = function(macchiato)
        return {
          -- Treesitter
          ['@boolean'] = { fg = macchiato.pink },
          ['@constant'] = { fg = macchiato.red },
          ['@constant.builtin'] = { fg = macchiato.yellow },
          ['@constant.macro'] = { fg = macchiato.mauve },
          ['@constructor'] = { fg = macchiato.teal },
          ['@danger'] = { fg = macchiato.base, bg = macchiato.red },
          ['@field'] = { fg = macchiato.text },
          ['@field.lua'] = { fg = macchiato.text },
          ['@float'] = { fg = macchiato.pink },
          ['@function'] = { fg = macchiato.sky },
          ['@function.builtin'] = { fg = macchiato.yellow },
          ['@function.macro'] = { fg = macchiato.teal },
          ['@include'] = { fg = macchiato.yellow, style = { 'italic' } },
          ['@keyword'] = { fg = macchiato.yellow, style = { 'italic' } },
          ['@keyword.function'] = { fg = macchiato.mauve },
          ['@keyword.operator'] = { fg = macchiato.peach },
          ['@keyword.return'] = { fg = macchiato.pink },
          ['@label'] = { fg = macchiato.sapphire },
          ['@method'] = { fg = macchiato.text },
          ['@namespace'] = { fg = macchiato.blue },
          ['@note'] = { fg = macchiato.base, bg = macchiato.blue },
          ['@number'] = { fg = macchiato.pink },
          ['@operator'] = { fg = macchiato.green },
          ['@parameter'] = { fg = macchiato.sky },
          ['@property'] = { fg = macchiato.flamingo },
          ['@punctuation.bracket'] = { fg = macchiato.text },
          ['@punctuation.special'] = { fg = macchiato.sky },
          ['@string'] = { fg = macchiato.green },
          ['@string.escape'] = { fg = macchiato.pink },
          ['@string.regex'] = { fg = macchiato.peach },
          ['@tag'] = { fg = macchiato.teal },
          ['@tag.attribute'] = { fg = macchiato.yellow },
          ['@tag.delimiter'] = { fg = macchiato.pink },
          ['@text'] = { fg = macchiato.text },
          ['@text.emphasis'] = { fg = macchiato.maroon },
          ['@text.literal'] = { fg = macchiato.teal },
          ['@text.reference'] = { fg = macchiato.lavender },
          ['@text.strong'] = { fg = macchiato.maroon },
          ['@text.title'] = { fg = macchiato.blue },
          ['@text.uri'] = { fg = macchiato.rosewater },
          ['@type'] = { fg = macchiato.peach },
          ['@type.builtin'] = { fg = macchiato.yellow },
          ['@variable'] = { fg = macchiato.text },
          ['@variable.builtin'] = { fg = macchiato.red },
          ['@warning'] = { fg = macchiato.base, bg = macchiato.yellow },
          -- TSX
          ['@constructor.tsx'] = { fg = macchiato.teal },
          ['@tag.tsx'] = { fg = macchiato.teal },
          ['@tag.attribute.tsx'] = { fg = macchiato.yellow, style = {
            'italic',
          } },
          ['@tag.delimiter.tsx'] = { fg = macchiato.pink },
          -- TS
          ['@constructor.ts'] = { fg = macchiato.teal },
          -- JSON
          ['@label.json'] = { fg = macchiato.yellow },
          -- LSP
          LspReferenceText = {
            bg = util.lighten(macchiato.base, 0.9),
            style = { 'bold' },
          },
          LspReferenceWrite = {
            bg = util.lighten(macchiato.base, 0.9),
            style = { 'bold' },
          },
          LspReferenceRead = {
            bg = util.lighten(macchiato.base, 0.9),
            style = { 'bold' },
          },
          ['@lsp.typemod.parameter.declaration'] = { style = { 'bold', 'italic' } },
          ['@lsp.type.parameter'] = { fg = macchiato.pink },
          -- Core
          Comment = { fg = macchiato.blue, style = { 'italic' } },
          Cursor = { fg = macchiato.text, bg = macchiato.pink }, -- character under the cursor
          CursorLine = { bg = util.darken(macchiato.base, 0.8) },
          Visual = { bg = macchiato.sapphire, fg = macchiato.crust, style = { 'bold' } },
          LineNr = { fg = macchiato.overlay0 },
          MatchWord = { fg = macchiato.teal, style = { 'italic', 'bold' } },
          MatchParen = { fg = macchiato.teal, bg = macchiato.base, style = { 'italic', 'bold' } },
          MatchParenCur = { fg = macchiato.teal, bg = macchiato.base, style = { 'italic', 'bold' } },
          Pmenu = { bg = macchiato.mantle, fg = macchiato.text },
          PmenuSel = { fg = macchiato.text, bg = macchiato.pink, style = { 'bold' } },
          Search = {
            bg = util.darken(macchiato.yellow, 0.5),
            fg = macchiato.text,
            style = { 'bold' },
          }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand oucp.
          VertSplit = { fg = macchiato.teal },
          Folded = { bg = util.darken(macchiato.base, 0.9) },
          -- Indent Blankline
          IndentBlanklineChar = { fg = util.lighten(macchiato.base, 0.9) },
          IndentBlanklineContextChar = { fg = macchiato.pink },
          -- Inlay Hints
          LspInlayHint = {
            fg = macchiato.surface0,
            bg = macchiato.base,
            style = { 'italic' },
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
            style = { 'italic', 'bold' },
          },
          TelescopePromptTitle = {
            fg = util.darken(macchiato.base, 0.8),
            bg = macchiato.pink,
            style = { 'italic', 'bold' },
          },
          TelescopeResultsTitle = {
            fg = util.darken(macchiato.base, 0.8),
            bg = util.darken(macchiato.base, 0.8),
          },
          TelescopeSelection = {
            bg = util.darken(macchiato.base, 0.8),
            fg = macchiato.flamingo,
            style = { 'italic', 'bold' },
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
          FlashLabel = { fg = macchiato.pink, style = { 'italic,bold' } },
          FlashMatch = {
            bg = util.darken(macchiato.yellow, 0.5),
            fg = macchiato.text,
          },
          -- Vim Visual Multi
          MultiCursorInsert = {
            fg = macchiato.text,
            style = { 'italic,bold' },
            bg = util.darken(macchiato.teal, 0.8),
          },
          MultiCursorExtend = { fg = macchiato.text, style = { 'italic,bold' }, bg = macchiato.pink },
          MultiCursorCursor = {
            fg = macchiato.pink,
            style = { 'italic,bold' },
            bg = util.darken(macchiato.base, 0.8),
          },
          MultiCursorMono = { fg = macchiato.text, style = { 'italic,bold' }, bg = macchiato.pink },
        }
      end,
    },
    color_overrides = {
      macchiato = colors,
    },
    styles = {
      keywords = { 'italic' },
      booleans = { 'italic' },
    },
  }

  -- Map treesitter highlights to semantic_tokens
  local links = {
    ['@lsp.type.namespace'] = '@namespace',
    ['@lsp.type.type'] = '@type',
    ['@lsp.type.class'] = '@type',
    ['@lsp.type.enum'] = '@type',
    ['@lsp.type.interface'] = '@type',
    ['@lsp.type.struct'] = '@structure',
    ['@lsp.type.parameter'] = '@parameter',
    ['@lsp.type.variable'] = '@variable',
    ['@lsp.type.property'] = '@property',
    ['@lsp.type.enumMember'] = '@constant',
    ['@lsp.type.function'] = '@function',
    ['@lsp.type.method'] = '@method',
    ['@lsp.type.macro'] = '@macro',
    ['@lsp.type.decorator'] = '@function',
  }

  for newgroup, oldgroup in pairs(links) do
    vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
  end

  vim.g.test = 'TTTTTT'
  vim.g.neoline_white = '#ffffff'
  vim.g.neoline_red = '#D45A7E'
  vim.g.neoline_orange = colors.flamingo
  vim.g.neoline_yellow = colors.yellow
  vim.g.neoline_green = '#FFFFFF'
  vim.g.neoline_turquoise = colors.green
  vim.g.neoline_aqua = colors.sky
  vim.g.neoline_blue = colors.blue
  vim.g.neoline_purple = colors.pink
  vim.g.neoline_green_light = '#D5F5E3'
  vim.g.neoline_purple_light = '#E8DAEF'
  vim.g.neoline_blue_light = '#D6EAF8'
  vim.g.neoline_red_light = '#FADBD8'

  vim.g.neoline_white_fg = '#e6e6e6'
  vim.g.neoline_gray = '#cccccc'

  vim.g.neoline_normal_fg = vim.g.neoline_gray
  vim.g.neoline_normal_bg = vim.g.neoline_white
  vim.g.neoline_activeline_bg = vim.g.neoline_blue
  vim.g.neoline_activeline_fg = '#ffffff'
  vim.g.neoline_inactiveline_bg = '#cccccc'
  vim.g.neoline_inactiveline_fg = '#ffffff'

  vim.cmd [[colorscheme catppuccin-macchiato]]
end

return M
