return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      appearance = { nerd_font_variant = "mono" },
      signature = {
        enabled = true,
        trigger = {
          show_on_keyword = true,
          blocked_trigger_characters = {},
          blocked_retrigger_characters = {},
          show_on_trigger_character = true,
          show_on_accept = true,
          show_on_accept_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
          show_on_insert = true,
        },
        window = {
          border = "rounded",
          show_documentation = true,
        },
      },
      completion = {
        trigger = {
          show_in_snippet = false,
          show_on_backspace = true,
          show_on_backspace_in_keyword = false,
        },
        list = {
          selection = {
            auto_insert = true,
            preselect = true,
          },
        },
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          update_delay_ms = 50,
          treesitter_highlighting = true,
          draw = function(opts)
            opts.default_implementation()
          end,
          window = {
            min_width = 10,
            max_width = 60,
            max_height = 80,
            border = "rounded",
          },
        },
        menu = {
          auto_show = true,
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          draw = {
            padding = 2,
            gap = 2,
            treesitter = { "lsp" },
            cursorline_priority = 0,
            columns = { { "kind_icon" }, { "label", "source_name", gap = 1 } },
            components = {
              kind_icon = {
                text = function(ctx)
                  local data = ctx.source_id == "codecompanion" and ctx.item.data
                  if data then
                    return data.type == "variable" and "" or data.type == "tool" and "󱁤" or "󰿠"
                  end
                  local is_copilot = ctx.source_id == "copilot"
                  if is_copilot then
                    return " "
                  end
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local is_copilot = ctx.source_id == "copilot"
                  if is_copilot then
                    return "Special"
                  end
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              source_name = {
                -- text = function(ctx)
                --   return vim.tbl_get(map, ctx.source_id, "icon") or ctx.source_name
                -- end,
                -- highlight = function(ctx)
                --   return vim.tbl_get(map, ctx.source_id, "hl") or "Comment"
                -- end,
              },
            },
          },
        },
      },
    },
  },
}
