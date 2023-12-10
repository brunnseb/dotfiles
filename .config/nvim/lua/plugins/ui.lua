return {
  {
    "catppuccin/nvim",
    config = function()
      local util = require("catppuccin.utils.colors")

      local colors = {
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
        blue = "#0088fe",
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
      }

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
  {
    "ecosse3/galaxyline.nvim",
    config = function()
      -- See: https://github.com/glepnir/galaxyline.nvim
      -- Modified by ecosse

      local icons = require("utils.icons")
      local gl = require("galaxyline")
      local condition = require("galaxyline.condition")
      -- local utils = require('utils')
      -- local tokyonight_colors = require("tokyonight.colors").setup({})
      local package_info_present, package = pcall(require, "package-info")

      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return nil
        else
          return "Recording @" .. recording_register
        end
      end

      -- Functions {{{2
      local function u(code)
        if type(code) == "string" then
          code = tonumber("0x" .. code)
        end
        local c = string.char
        if code <= 0x7f then
          return c(code)
        end
        local t = {}

        if code <= 0x07ff then
          t[1] = c(bit.bor(0xc0, bit.rshift(code, 6)))
          t[2] = c(bit.bor(0x80, bit.band(code, 0x3f)))
        elseif code <= 0xffff then
          t[1] = c(bit.bor(0xe0, bit.rshift(code, 12)))
          t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 6), 0x3f)))
          t[3] = c(bit.bor(0x80, bit.band(code, 0x3f)))
        else
          t[1] = c(bit.bor(0xf0, bit.rshift(code, 18)))
          t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 12), 0x3f)))
          t[3] = c(bit.bor(0x80, bit.band(bit.rshift(code, 6), 0x3f)))
          t[4] = c(bit.bor(0x80, bit.band(code, 0x3f)))
        end

        return table.concat(t)
      end

      local function highlight(group, fg, bg, gui)
        local cmd = string.format("highlight %s guifg=%s guibg=%s", group, fg, bg)

        if gui ~= nil then
          cmd = cmd .. " gui=" .. gui
        end

        vim.cmd(cmd)
      end

      -- }}}2

      -- Settings {{{2
      local lineLengthWarning = 80
      local lineLengthError = 120
      local leftbracket = "" -- Curve.
      local rightbracket = "" -- Curve.
      -- local leftbracket = u 'e0b2' -- Angle filled.
      -- local rightbracket = u 'e0b0' -- Angle filled.
      -- local leftbracket = u 'e0b3' -- Angle.
      -- local rightbracket = u 'e0b1' -- Angle.
      -- }}}2

      gl.short_line_list = { "NvimTree", "vista", "dbui", "packer", "tagbar" }
      local gls = gl.section

      -- local bgcolor = function()
      --   if EcoVim.colorscheme == 'nightfly' then
      --     return '#011627'
      --   else
      --     return nil;
      --   end
      -- end

      -- Colours, maps and icons {{{2
      local colors = {
        bg = nil,
        modetext = "#000000",

        giticon = "#FF8800",
        gitbg = "#5C2C2E",
        gittext = "#C5C5C5",

        diagerror = "#F44747",
        diagwarn = "#FF8800",
        diaghint = "#4FC1FF",
        diaginfo = "#FFCC66",

        lspicon = "#68AF00",
        lspbg = "#304B2E",
        lsptext = "#C5C5C5",

        typeicon = "#FF8800",
        typebg = "#5C2C2E",
        typetext = "#C5C5C5",

        statsicon = "#9CDCFE",
        statsbg = "#5080A0",
        statstext = "#000000",

        lineokfg = "#000000",
        lineokbg = "#5080A0",
        linelongerrorfg = "#FF0000",
        linelongwarnfg = "#FFFF00",
        linelongbg = "#5080A0",

        shortbg = "#DCDCAA",
        shorttext = "#000000",

        shortrightbg = "#3F3F3F",
        shortrighttext = "#7C4C4E",

        gpsbg = "#5C00A3",
        gpstext = "#C5C5C5",

        red = "#D16969",
        yellow = "#DCDCAA",
        magenta = "#D16D9E",
        green = "#608B4E",
        orange = "#FF8800",
        purple = "#C586C0",
        blue = "#569CD6",
        cyan = "#4EC9B0",
      }

      local mode_map = {
        ["n"] = { "#569CD6", "NORMAL" },
        ["i"] = { "#D16969", "INSERT" },
        ["R"] = { "#D16969", "REPLACE" },
        ["c"] = { "#608B4E", "COMMAND" },
        ["v"] = { "#C586C0", "VISUAL" },
        ["V"] = { "#C586C0", "VIS-LN" },
        [""] = { "#C586C0", "VIS-BLK" },
        ["s"] = { "#FF8800", "SELECT" },
        ["S"] = { "#FF8800", "SEL-LN" },
        [""] = { "#DCDCAA", "SEL-BLK" },
        ["t"] = { "#569CD6", "TERMINAL" },
        ["Rv"] = { "#D16D69", "VIR-REP" },
        ["rm"] = { "#FF0000", "- More -" },
        ["r"] = { "#FF0000", "- Hit-Enter -" },
        ["r?"] = { "#FF0000", "- Confirm -" },
        ["cv"] = { "#569CD6", "Vim Ex Mode" },
        ["ce"] = { "#569CD6", "Normal Ex Mode" },
        ["!"] = { "#569CD6", "Shell Running" },
        ["ic"] = { "#DCDCAA", "Insert mode completion |compl-generic|" },
        ["no"] = { "#DCDCAA", "Operator-pending" },
        ["nov"] = { "#DCDCAA", "Operator-pending (forced charwise |o_v|)" },
        ["noV"] = { "#DCDCAA", "Operator-pending (forced linewise |o_V|)" },
        ["noCTRL-V"] = { "#DCDCAA", "Operator-pending (forced blockwise |o_CTRL-V|) CTRL-V is one character" },
        ["niI"] = { "#DCDCAA", "Normal using |i_CTRL-O| in |Insert-mode|" },
        ["niR"] = { "#DCDCAA", "Normal using |i_CTRL-O| in |Replace-mode|" },
        ["niV"] = { "#DCDCAA", "Normal using |i_CTRL-O| in |Virtual-Replace-mode|" },
        ["ix"] = { "#DCDCAA", "Insert mode |i_CTRL-X| completion" },
        ["Rc"] = { "#DCDCAA", "Replace mode completion |compl-generic|" },
        ["Rx"] = { "#DCDCAA", "Replace mode |i_CTRL-X| completion" },
      }

      -- See: https://www.nerdfonts.com/cheat-sheet
      local icons = {
        vim = u("e62b"),
        dos = u("e70f"),
        unix = u("f17c"),
        mac = u("f179"),
      }
      -- }}}2

      -- Rag status function {{{2
      local function setLineWidthColours()
        local colbg = colors.statsbg
        local linebg = colors.statsbg

        if vim.fn.col(".") > lineLengthError then
          colbg = colors.linelongerrorfg
        elseif vim.fn.col(".") > lineLengthWarning then
          colbg = colors.linelongwarnfg
        end

        if vim.fn.strwidth(vim.fn.getline(".")) > lineLengthError then
          linebg = colors.linelongerrorfg
        elseif vim.fn.strwidth(vim.fn.getline(".")) > lineLengthWarning then
          linebg = colors.linelongwarnfg
        end

        highlight("LinePosHighlightStart", colbg, colors.statsbg)
        highlight("LinePosHighlightColNum", colors.statstext, colbg)
        highlight("LinePosHighlightMid", linebg, colbg)
        highlight("LineLenHighlightLenNum", colors.statstext, linebg)
        highlight("LinePosHighlightEnd", linebg, colors.statsbg)
      end

      -- }}}2

      -- }}}1

      -- Left {{{1
      gls.left = {}

      -- Edit mode {{{2
      table.insert(gls.left, {
        ViModeSpaceOnFarLeft = {
          provider = function()
            return " "
          end,
          highlight = { colors.giticon, colors.bg },
        },
      })
      table.insert(gls.left, {
        ViModeLeft = {
          provider = function()
            highlight("ViModeHighlight", mode_map[vim.fn.mode()][1], colors.bg)
            return leftbracket
          end,
          highlight = "ViModeHighlight",
        },
      })
      table.insert(gls.left, {
        ViModeIconAndText = {
          provider = function()
            highlight("GalaxyViMode", colors.modetext, mode_map[vim.fn.mode()][1])

            return icons["vim"] .. " " .. mode_map[vim.fn.mode()][2]
          end,
          highlight = "GalaxyViMode",
        },
      })
      table.insert(gls.left, {
        ViModeRight = {
          provider = function()
            return rightbracket
          end,
          separator = " ",
          separator_highlight = "ViModeHighlight",
          highlight = "ViModeHighlight",
        },
      })
      -- }}}2

      -- Git info {{{2

      -- Git Branch Name {{{3
      table.insert(gls.left, {
        GitStart = {
          provider = function()
            return leftbracket
          end,
          condition = condition.check_git_workspace,
          highlight = { colors.giticon, colors.bg },
        },
      })
      table.insert(gls.left, {
        GitIcon = {
          provider = function()
            return " "
          end,
          condition = condition.check_git_workspace,
          separator = "",
          separator_highlight = { "NONE", colors.giticon },
          highlight = { colors.gitbg, colors.giticon },
        },
      })
      table.insert(gls.left, {
        GitMid = {
          provider = function()
            return rightbracket .. " "
          end,
          condition = condition.check_git_workspace,
          highlight = { colors.giticon, colors.gitbg },
        },
      })
      table.insert(gls.left, {
        GitBranch = {
          provider = "GitBranch",
          condition = condition.check_git_workspace,
          separator = " ",
          separator_highlight = { "NONE", colors.gitbg },
          highlight = { colors.gittext, colors.gitbg },
        },
      })
      -- }}}3

      -- Git Changes {{{3
      table.insert(gls.left, {
        DiffAdd = {
          provider = "DiffAdd",
          condition = condition.check_git_workspace,
          icon = "  ",
          highlight = { colors.green, colors.gitbg },
        },
      })
      table.insert(gls.left, {
        DiffModified = {
          provider = "DiffModified",
          condition = condition.check_git_workspace,
          icon = "  ",
          highlight = { colors.blue, colors.gitbg },
        },
      })
      table.insert(gls.left, {
        DiffRemove = {
          provider = "DiffRemove",
          condition = condition.check_git_workspace,
          icon = "  ",
          highlight = { colors.red, colors.gitbg },
        },
      })
      table.insert(gls.left, {
        EndGit = {
          provider = function()
            return rightbracket
          end,
          condition = condition.check_git_workspace,
          separator = " ",
          separator_highlight = { colors.gitbg, colors.bg },
          highlight = { colors.gitbg, colors.bg },
        },
      })
      -- }}}3

      -- }}}2

      -- Lsp Section {{{2

      -- Lsp Client {{{3
      table.insert(gls.left, {
        LspStart = {
          provider = function()
            return leftbracket
          end,
          highlight = { colors.lspicon, colors.bg },
        },
      })
      table.insert(gls.left, {
        LspIcon = {
          provider = function()
            local name = ""
            if gl.lspclient ~= nil then
              name = gl.lspclient()
            end
            return " " .. name
          end,
          highlight = { colors.lspbg, colors.lspicon },
        },
      })
      table.insert(gls.left, {
        LspMid = {
          provider = function()
            return rightbracket .. " "
          end,
          highlight = { colors.lspicon, colors.lspbg },
        },
      })
      table.insert(gls.left, {
        ShowLspClient = {
          provider = "GetLspClient",
          highlight = { colors.textbg, colors.lspbg },
        },
      })
      table.insert(gls.left, {
        LspSpace = {
          provider = function()
            return " "
          end,
          highlight = { colors.lspicon, colors.lspbg },
        },
      })
      -- }}}3

      -- Diagnostics {{{3
      table.insert(gls.left, {
        DiagnosticError = {
          provider = "DiagnosticError",
          icon = icons.errorOutline,
          separator_highlight = { colors.gitbg, colors.bg },
          highlight = { colors.diagerror, colors.lspbg },
        },
      })
      table.insert(gls.left, {
        DiagnosticWarn = {
          provider = "DiagnosticWarn",
          icon = "  ",
          highlight = { colors.diagwarn, colors.lspbg },
        },
      })
      table.insert(gls.left, {
        DiagnosticHint = {
          provider = "DiagnosticHint",
          icon = icons.lightbulbOutline,
          highlight = { colors.diaghint, colors.lspbg },
        },
      })
      table.insert(gls.left, {
        DiagnosticInfo = {
          provider = "DiagnosticInfo",
          icon = icons.infoOutline,
          highlight = { colors.diaginfo, colors.lspbg },
        },
      })
      table.insert(gls.left, {
        LspSectionEnd = {
          provider = function()
            return rightbracket .. " "
          end,
          highlight = { colors.lspbg, colors.bg },
        },
      })
      -- }}}3

      -- GPS {{{3
      -- table.insert(gls.left, {
      --     nvimGPS = {
      --       provider = function()
      --         return gps.get_location()
      --       end,
      --       condition = function()
      --         return gps.is_available() and #gps.get_location() > 0
      --       end,
      --       highlight = {colors.gpstext, colors.bg}
      --     }
      -- })
      -- }}}3

      -- }}}2

      -- }}}1

      -- Right {{{1
      gls.right = {}

      if package_info_present then
        table.insert(gls.right, {
          PackageInfoStatus = {
            provider = function()
              return package.get_status() .. " "
            end,
          },
        })
      end
      table.insert(gls.right, {
        RecordingStart = {
          provider = function()
            if show_macro_recording() then
              return leftbracket
            end
          end,
          highlight = { colors.typeicon, colors.bg },
        },
      })
      table.insert(gls.right, {
        Recording = {
          provider = function()
            return show_macro_recording()
          end,
          highlight = { colors.typebg, colors.typeicon },
        },
      })
      table.insert(gls.right, {
        RecordingMid = {
          provider = function()
            if show_macro_recording() then
              return rightbracket .. " "
            end
          end,
          highlight = { colors.typeicon, colors.typebg },
        },
      })

      -- Type {{{2
      table.insert(gls.right, {
        TypeStart = {
          provider = function()
            return leftbracket
          end,
          highlight = { colors.typeicon, colors.bg },
        },
      })
      table.insert(gls.right, {
        TypeFileFormatIcon = {
          provider = function()
            local icon = icons[vim.bo.fileformat] or ""
            return string.format(" %s", icon)
          end,
          highlight = { colors.typebg, colors.typeicon },
        },
      })
      table.insert(gls.right, {
        TypeMid = {
          provider = function()
            return rightbracket .. " "
          end,
          highlight = { colors.typeicon, colors.typebg },
        },
      })

      -- if EcoVim.statusline.path_enabled then
      --   table.insert(gls.right, {
      --     FileName = {
      --       provider = function()
      --         if #vim.fn.expand '%:p' == 0 then
      --           return ''
      --         end
      --
      --         if EcoVim.statusline.path == 'relative' then
      --           local fname = vim.fn.expand('%:p')
      --           return fname:gsub(vim.fn.getcwd() .. '/', '') .. ' '
      --         end
      --
      --         return vim.fn.expand '%:t' .. ' '
      --       end,
      --       separator_highlight = { 'NONE', colors.typebg },
      --       highlight = { colors.typetext, colors.typebg }
      --     }
      --   })
      -- end
      table.insert(gls.right, {
        FileIcon = {
          provider = "FileIcon",
          highlight = { colors.typeicon, colors.typebg },
        },
      })
      table.insert(gls.right, {
        BufferType = {
          provider = "FileTypeName",
          highlight = { colors.typetext, colors.typebg },
        },
      })
      table.insert(gls.right, {
        FileSize = {
          provider = "FileSize",
          separator = "  ",
          separator_highlight = { colors.typeicon, colors.typebg },
          highlight = { colors.typetext, colors.typebg },
        },
      })
      table.insert(gls.right, {
        FileEncode = {
          provider = "FileEncode",
          separator = "",
          separator_highlight = { colors.typeicon, colors.typebg },
          highlight = { colors.typetext, colors.typebg },
        },
      })
      table.insert(gls.right, {
        TypeSectionEnd = {
          provider = function()
            return rightbracket
          end,
          highlight = { colors.typebg, colors.bg },
        },
      })
      table.insert(gls.right, {
        Space = {
          provider = function()
            return " "
          end,
          highlight = { colors.typebg, colors.bg },
        },
      })
      -- }}}2

      -- Cursor Position Section {{{2
      table.insert(gls.right, {
        StatsSectionStart = {
          provider = function()
            return leftbracket
          end,
          highlight = { colors.statsicon, colors.bg },
        },
      })
      table.insert(gls.right, {
        StatsIcon = {
          provider = function()
            return " ⅑ "
          end,
          highlight = { colors.statsbg, colors.statsicon },
        },
      })
      table.insert(gls.right, {
        StatsMid = {
          provider = function()
            return rightbracket .. " "
          end,
          highlight = { colors.statsicon, colors.statsbg },
        },
      })
      table.insert(gls.right, {
        PerCent = {
          provider = "LinePercent",
          highlight = { colors.statstext, colors.statsbg },
        },
      })
      table.insert(gls.right, {
        VerticalPosAndSize = {
          provider = function()
            return string.format(" %s /%4i ", vim.fn.line("."), vim.fn.line("$"))
          end,
          separator = "",
          separator_highlight = { colors.statsicon, colors.statsbg },
          highlight = { colors.statstext, colors.statsbg },
        },
      })
      table.insert(gls.right, {
        CursorColumnStart = {
          provider = function()
            return leftbracket
          end,
          separator = " ",
          separator_highlight = { colors.statsicon, colors.statsbg },
          highlight = "LinePosHighlightStart",
        },
      })
      table.insert(gls.right, {
        CursorColumn = {
          provider = function()
            setLineWidthColours()
            return "" .. string.format("%3i", vim.fn.col(".")) .. " /"
          end,
          highlight = "LinePosHighlightColNum",
        },
      })
      table.insert(gls.right, {
        LineLengthStart = {
          provider = function()
            return " " .. leftbracket
          end,
          highlight = "LinePosHighlightMid",
        },
      })
      table.insert(gls.right, {
        LineLength = {
          provider = function()
            return " " .. string.format("%3i", string.len(vim.fn.getline(".")))
          end,
          highlight = "LineLenHighlightLenNum",
        },
      })
      table.insert(gls.right, {
        LineLengthEnd = {
          provider = function()
            return " " .. rightbracket .. " "
          end,
          highlight = "LinePosHighlightEnd",
        },
      })
      table.insert(gls.right, {
        TabOrSpace = {
          provider = function()
            if vim.bo.expandtab then
              return " 󰄮 "
            else
              return " 󰄱 "
            end
          end,
          condition = condition.hide_in_width,
          highlight = { colors.statsicon, colors.statsbg },
        },
      })
      table.insert(gls.right, {
        Tabstop = {
          provider = function()
            if vim.bo.expandtab then
              return vim.bo.shiftwidth
            else
              return vim.bo.shiftwidth
            end
          end,
          condition = condition.hide_in_width,
          highlight = { colors.statstext, colors.statsbg },
        },
      })
      table.insert(gls.right, {
        StatsSpcSectionEnd = {
          provider = function()
            return rightbracket .. " "
          end,
          highlight = { colors.statsbg, colors.bg },
        },
      })
      -- }}}2

      -- }}}1

      -- Left Short {{{1
      gls.short_line_left = {}

      table.insert(gls.short_line_left, {
        ShortSectionStart = {
          provider = function()
            return leftbracket
          end,
          highlight = { colors.shortbg, colors.bg },
        },
      })
      table.insert(gls.short_line_left, {
        ShortSectionSpace = {
          provider = function()
            return " "
          end,
          highlight = { colors.shorttext, colors.shortbg },
        },
      })
      table.insert(gls.short_line_left, {
        LeftShortName = {
          provider = "FileTypeName",
          highlight = { colors.shorttext, colors.shortbg },
        },
      })
      table.insert(gls.short_line_left, {
        ShortSectionMid = {
          provider = function()
            return " "
          end,
          highlight = { colors.shortbg, colors.shortbg },
        },
      })
      table.insert(gls.short_line_left, {
        LeftShortFileName = {
          provider = "SFileName",
          condition = condition.buffer_not_empty,
          separator_highlight = { colors.shorttext, colors.shortbg },
          highlight = { colors.shorttext, colors.shortbg },
        },
      })
      table.insert(gls.short_line_left, {
        ShortSectionEnd = {
          provider = function()
            return rightbracket
          end,
          highlight = { colors.shortbg, colors.bg },
        },
      })
      -- }}}1

      -- Right Short {{{1
      gls.short_line_right = {}

      table.insert(gls.short_line_right, {
        BufferIcon = {
          provider = "BufferIcon",
          separator_highlight = { colors.shorttext, colors.bg },
          highlight = { colors.shortrighttext, colors.bg },
        },
      })
      -- }}}1
    end,
    event = "VeryLazy",
  },
}
