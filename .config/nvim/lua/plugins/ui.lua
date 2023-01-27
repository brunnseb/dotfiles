return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Cobalt Colors
      local colors = {
        red = "#FF6CA4",
        grey = "#7C7F93",
        light_grey = "#BCC0CC",
        black = "#1A3549",
        transparent = "#122432",
        white = "#E2EFFE",
        light_green = "#84DCC6",
        blue = "#006dcc",
        green = "#00C8A0",
        yellow = "#FFD701",
        orange = "#dc8a78",
        cyan = "#90EBED",
      }

      local cobalt = {
        normal = {
          a = { fg = colors.transparent, bg = colors.green, gui = "bold" },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.black, bg = colors.transparent },
          z = { fg = colors.white, bg = colors.black },
        },
        insert = { a = { fg = colors.transparent, bg = colors.blue, gui = "bold" } },
        visual = { a = { fg = colors.transparent, bg = colors.red, gui = "bold" } },
        replace = { a = { fg = colors.black, bg = colors.green, gui = "bold" } },
      }

      local empty = require("lualine.component"):extend()
      function empty:draw(default_highlight)
        self.status = ""
        self.applied_separator = ""
        self:apply_highlights(default_highlight)
        self:apply_section_separators()
        return self.status
      end

      -- Put proper separators and gaps between components in sections
      local function process_sections(sections)
        for name, section in pairs(sections) do
          local left = name:sub(9, 10) < "x"
          for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
            table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.transparent } })
          end
          for id, comp in ipairs(section) do
            if type(comp) ~= "table" then
              comp = { comp }
              section[id] = comp
            end
            comp.separator = left and { right = "" } or { left = "" }
            -- comp.separator = left and { right = '' } or { left = '' }
          end
        end
        return sections
      end

      local function search_result()
        if vim.v.hlsearch == 0 then
          return ""
        end
        local last_search = vim.fn.getreg("/")
        if not last_search or last_search == "" then
          return ""
        end
        local searchcount = vim.fn.searchcount({ maxcount = 9999 })
        return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
      end

      local function modified()
        if vim.bo.modified then
          return "+"
        elseif vim.bo.modifiable == false or vim.bo.readonly == true then
          return "-"
        end
        return ""
      end

      opts.options = {
        theme = cobalt,
        component_separators = "",
        globalstatus = true,
      }

      opts.sections = process_sections({
        lualine_a = { "mode" },
        lualine_b = {
          { "filename", file_status = false, path = 4 },
          {
            "diagnostics",
            source = { "intelephense", "quick-lint-js" },
            sections = { "error" },
            diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
          },
          {
            "diagnostics",
            source = { "intelephense", "quick-lint-js" },
            sections = { "warn" },
            diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
          },
          {
            "diagnostics",
            source = { "intelephense", "tsserver" },
            sections = { "hint" },
            diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
          },
          { modified, color = { fg = colors.transparent, bg = colors.yellow } },
        },
        lualine_c = { "aerial" },
        lualine_x = {}, -- { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available  }
        lualine_y = { search_result },
        lualine_z = { "branch" },
      })

      opts.inactive_sections = {
        lualine_c = { "%f %y %m" },
        lualine_x = {},
      }
    end,
  },
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    config = function()
      local util = require("catppuccin.utils.colors")

      require("catppuccin").setup({
        flavour = "macchiato", -- mocha, macchiato, frappe, latte
        integrations = {
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
          -- lsp_trouble = true,
          which_key = false,
          telescope = false,
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
      })
      vim.api.nvim_command("colorscheme catppuccin-macchiato")
    end,
    build = ":CatppuccinCompile",
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    dependencies = { "folke/twilight.nvim" },
    opts = function(_, opts)
      opts.window = {
        backdrop = 0.8,
      }
      opts.plugins = {
        gitsigns = { enabled = true },
        kitty = {
          enabled = true,
          font = "+3", -- font size increment
        },
      }
      opts.on_open = function()
        require("gitsigns").toggle_signs()
      end
    end,
  },
}
