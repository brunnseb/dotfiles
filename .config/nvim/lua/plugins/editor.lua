return {
  {
    "nanozuki/tabby.nvim",
    config = function()
      function tab_name(tab)
        return string.gsub(tab, "%[..%]", "")
      end

      function tab_modified(tab)
        wins = require("tabby.module.api").get_tab_wins(tab)
        for i, x in pairs(wins) do
          if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
            return ""
          end
        end
        return ""
      end

      function lsp_diag(buf)
        diagnostics = vim.diagnostic.get(buf)
        local count = { 0, 0, 0, 0 }

        for _, diagnostic in ipairs(diagnostics) do
          count[diagnostic.severity] = count[diagnostic.severity] + 1
        end
        if count[1] > 0 then
          return vim.bo[buf].modified and "" or ""
        elseif count[2] > 0 then
          return vim.bo[buf].modified and "" or ""
        end
        return vim.bo[buf].modified and "" or ""
      end

      local function get_modified(buf)
        if vim.bo[buf].modified then
          return ""
        else
          return ""
        end
      end

      local function buffer_name(buf)
        if string.find(buf, "NvimTree") then
          return "NvimTree"
        end
        return buf
      end

      local theme = {
        fill = "TabFill",
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        head = "TabLineHead",
        current_tab = "TabLineSel",
        inactive_tab = "TabLineIn",
        tab = "TabLine",
        win = "TabLineHead",
        tail = "TabLineHead",
      }
      require("tabby.tabline").set(function(line)
        return {
          {
            { "  ", hl = theme.head },
            line.sep("", theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.inactive_tab
            return {
              line.sep("", hl, theme.fill),
              tab.number(),
              "",
              tab_name(tab.name()),
              "",
              tab_modified(tab.id),
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            local hl = win.is_current() and theme.current_tab or theme.inactive_tab
            return {
              line.sep("", hl, theme.fill),
              win.file_icon(),
              "",
              buffer_name(win.buf_name()),
              "",
              lsp_diag(win.buf().id),
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          {
            line.sep("", theme.tail, theme.fill),
            { "  ", hl = theme.tail },
          },
          hl = theme.fill,
        }
      end)
    end,
    -- config = function()
    --   local function tab_name(tab)
    --     return string.gsub(tab, "%[..%]", "")
    --   end
    --
    --   local function tab_modified(tab)
    --     local wins = require("tabby.module.api").get_tab_wins(tab)
    --     for _, x in pairs(wins) do
    --       if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
    --         return ""
    --       end
    --     end
    --     return ""
    --   end
    --
    --   local function lsp_diag(buf)
    --     local diagnostics = vim.diagnostic.get(buf)
    --     local count = { 0, 0, 0, 0 }
    --
    --     for _, diagnostic in ipairs(diagnostics) do
    --       count[diagnostic.severity] = count[diagnostic.severity] + 1
    --     end
    --     if count[1] > 0 then
    --       return vim.bo[buf].modified and "" or ""
    --     elseif count[2] > 0 then
    --       return vim.bo[buf].modified and "" or ""
    --     end
    --     return vim.bo[buf].modified and "" or ""
    --   end
    --
    --   local function buffer_name(buf)
    --     if string.find(buf, "NvimTree") then
    --       return "NvimTree"
    --     end
    --     return buf
    --   end
    --
    --   local theme = {
    --     fill = "TabFill",
    --     -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
    --     head = "TabLineHead",
    --     current_tab = "TabLineSel",
    --     inactive_tab = "TabLineIn",
    --     tab = "TabLine",
    --     win = "TabLineHead",
    --     tail = "TabLineHead",
    --   }
    --   require("tabby.tabline").set(function(line)
    --     return {
    --       {
    --         { "  ", hl = theme.head },
    --         line.sep("", theme.head, theme.fill),
    --       },
    --       line.tabs().foreach(function(tab)
    --         local hl = tab.is_current() and theme.current_tab or theme.inactive_tab
    --         return {
    --           line.sep("", hl, theme.fill),
    --           tab.number(),
    --           "",
    --           tab_name(tab.name()),
    --           "",
    --           tab_modified(tab.id),
    --           line.sep("", hl, theme.fill),
    --           hl = hl,
    --           margin = " ",
    --         }
    --       end),
    --       line.spacer(),
    --       line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
    --         local hl = win.is_current() and theme.current_tab or theme.inactive_tab
    --         return {
    --           line.sep("", hl, theme.fill),
    --           win.file_icon(),
    --           "",
    --           buffer_name(win.buf_name()),
    --           "",
    --           lsp_diag(win.buf().id),
    --           line.sep("", hl, theme.fill),
    --           hl = hl,
    --           margin = " ",
    --         }
    --       end),
    --       {
    --         line.sep("", theme.tail, theme.fill),
    --         { "  ", hl = theme.tail },
    --       },
    --       hl = theme.fill,
    --     }
    --   end)
    -- end,
  },
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup({
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            buftype = { "terminal", "quickfix" },
          },
        },
        other_win_hl_color = "#FF6CA4",
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
    },
    keys = {
      { "<leader>E", false },
      {
        "<leader>e",
        "<leader>fE",
        desc = "Explorer NeoTree (cwd)",
        remap = true,
      },
    },
    opts = {
      window = {
        mappings = {
          ["s"] = "split_with_window_picker",
          ["v"] = "vsplit_with_window_picker",
          ["<cr>"] = "open_with_window_picker",
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>j"] = { name = "+portal" },
        ["<leader>m"] = { name = "+misc" },
        ["<leader>p"] = { name = "+project" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "+tabs" },
        ["<leader>T"] = { name = "+testing" },
        ["<leader>sn"] = { name = "+noice" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      })
    end,
  },
}
