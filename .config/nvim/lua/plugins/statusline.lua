return {
  {
    "nvimdev/galaxyline.nvim",
    config = function()
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

      local function highlight(group, fg, bg, gui)
        local cmd = string.format("highlight %s guifg=%s guibg=%s", group, fg, bg)

        if gui ~= nil then
          cmd = cmd .. " gui=" .. gui
        end

        vim.cmd(cmd)
      end

      local lineLengthWarning = 80
      local lineLengthError = 120
      local leftbracket = "" -- Curve.
      local rightbracket = "" -- Curve.

      gl.short_line_list = { "neo-tree", "vista", "dbui", "packer", "tagbar" }
      local gls = gl.section

      -- local bgcolor = function()
      --   if EcoVim.colorscheme == 'nightfly' then
      --     return '#011627'
      --   else
      --     return nil;
      --   end
      -- end

      local util = require("catppuccin.utils.colors")
      local catppuccin_colors = require("utils.colorscheme").catppucinn_colors
      -- Colours, maps and icons {{{2
      local colors = {
        bg = nil,
        modetext = "#000000",

        giticon = catppuccin_colors.peach,
        gitbg = util.darken(catppuccin_colors.peach, 0.5),
        gittext = catppuccin_colors.text,

        diagerror = catppuccin_colors.red,
        diagwarn = catppuccin_colors.peach,
        diaghint = catppuccin_colors.teal,
        diaginfo = catppuccin_colors.yellow,

        lspicon = util.darken(catppuccin_colors.teal, 0.3),
        lspbg = catppuccin_colors.teal,
        lsptext = "#000000",

        typeicon = catppuccin_colors.text,
        typebg = catppuccin_colors.maroon,
        typetext = catppuccin_colors.text,

        statsicon = catppuccin_colors.sky,
        statsbg = util.darken(catppuccin_colors.sky, 0.7),
        statstext = "#000000",

        linelongerrorfg = catppuccin_colors.red,
        linelongwarnfg = catppuccin_colors.peach,

        shortbg = catppuccin_colors.pink,
        shorttext = catppuccin_colors.text,
      }

      local mode_map = {
        ["n"] = { catppuccin_colors.blue, "NORMAL" },
        ["i"] = { catppuccin_colors.maroon, "INSERT" },
        ["R"] = { catppuccin_colors.maroon, "REPLACE" },
        ["c"] = { catppuccin_colors.green, "COMMAND" },
        ["v"] = { catppuccin_colors.pink, "VISUAL" },
        ["V"] = { catppuccin_colors.pink, "VIS-LN" },
        [""] = { catppuccin_colors.pink, "VIS-BLK" },
        ["s"] = { catppuccin_colors.peach, "SELECT" },
        ["S"] = { catppuccin_colors.peach, "SEL-LN" },
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

      local function getBg()
        if vim.g.colors_name == "tokyonight" then
          return require("tokyonight.colors").setup().bg
        else
          return catppuccin_colors.base
        end
      end

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

            return mode_map[vim.fn.mode()][2]
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
            return " "
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
          highlight = { catppuccin_colors.teal, colors.gitbg },
        },
      })
      table.insert(gls.left, {
        DiffModified = {
          provider = "DiffModified",
          condition = condition.check_git_workspace,
          icon = "  ",
          highlight = { catppuccin_colors.yellow, colors.gitbg },
        },
      })
      table.insert(gls.left, {
        DiffRemove = {
          provider = "DiffRemove",
          condition = condition.check_git_workspace,
          icon = "  ",
          highlight = { catppuccin_colors.red, colors.gitbg },
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
          highlight = { colors.lsptext, colors.lspbg },
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
        LspEnd = {
          provider = function()
            return rightbracket .. " "
          end,
          highlight = { colors.lspbg, colors.bg },
        },
      })

      table.insert(gls.left, {
        DiagnosticStart = {
          provider = function()
            return leftbracket
          end,
          highlight = { getBg, "NONE" },
        },
      })
      table.insert(gls.left, {
        DiagnosticError = {
          provider = "DiagnosticError",
          icon = icons.errorOutline,
          highlight = { colors.diagerror, getBg },
        },
      })
      table.insert(gls.left, {
        DiagnosticWarn = {
          provider = "DiagnosticWarn",
          icon = " ",
          highlight = { colors.diagwarn, getBg },
        },
      })
      table.insert(gls.left, {
        DiagnosticHint = {
          provider = "DiagnosticHint",
          icon = icons.lightbulbOutline,
          highlight = { colors.diaghint, getBg },
        },
      })
      table.insert(gls.left, {
        DiagnosticInfo = {
          provider = "DiagnosticInfo",
          icon = icons.infoOutline,
          highlight = { colors.diaginfo, getBg },
        },
      })
      table.insert(gls.left, {
        DiagnosticEnd = {
          provider = function()
            return rightbracket
          end,
          highlight = { getBg, "NONE" },
        },
      })
      -- }}}3

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
          highlight = { colors.typeicon, colors.bg },
        },
      })

      -- Type {{{2
      table.insert(gls.right, {
        TypeStart = {
          provider = function()
            if #vim.fn.expand("%:p") ~= 0 then
              return leftbracket
            end
          end,
          highlight = { colors.typebg, colors.bg },
        },
      })

      table.insert(gls.right, {
        FileName = {
          provider = function()
            if #vim.fn.expand("%:p") == 0 then
              return ""
            end

            return vim.fn.expand("%:t") .. " "
          end,
          separator_highlight = { "NONE", colors.typebg },
          highlight = { colors.typetext, colors.typebg },
        },
      })
      table.insert(gls.right, {
        TypeSectionEnd = {
          provider = function()
            if #vim.fn.expand("%:p") ~= 0 then
              return rightbracket
            end
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
        SearchResults = {
          separator = "? ",
          separator_highlight = { colors.statsicon, colors.statsbg },
          condition = function()
            local search_count = vim.fn.searchcount({
              recompute = 1,
              maxcount = -1,
            })

            local active_result = vim.v.hlsearch == 1 and search_count.total ~= nil and search_count.total > 0

            return active_result
          end,
          provider = function()
            local search_term = vim.fn.getreg("/")
            local search_count = vim.fn.searchcount({
              recompute = 1,
              maxcount = -1,
            })

            local active_result = vim.v.hlsearch == 1 and search_count.total > 0
            if active_result then
              return string.format("%s [%d/%d]", search_term, search_count.current, search_count.total)
            end
          end,
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
