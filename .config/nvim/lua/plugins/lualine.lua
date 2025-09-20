return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons
      local codecompanion_spinner = require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component()
      codecompanion_spinner.color = function()
        return { fg = Snacks.util.color("Statement") }
      end

      opts.sections = {
        lualine_x = {
          codecompanion_spinner,
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = function()
              return { fg = Snacks.util.color("Debug") }
            end,
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return { fg = Snacks.util.color("Special") }
            end,
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
      }
    end,
  },
}
