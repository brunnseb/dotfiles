local wrap_component = function(component, color, opts, condition)
  local left = {
    provider = '',
    hl = { fg = color },
    condition = condition,
  }
  local right = {
    provider = '',
    hl = { fg = color },
    condition = condition,
  }
  local separator = {
    provider = ' ',
    hl = 'Normal',
  }

  return {
    left,
    component(vim.tbl_deep_extend('force', { surround = { separator = 'none', color = color } }, opts or {})),
    right,
    separator,
  }
end

return {
  {
    'aikow/base.nvim',
    priority = 1000,
    lazy = false,
    opts = {},
    dependencies = {
      'rebelot/heirline.nvim',
      'zeioth/heirline-components.nvim',
    },
    config = function()
      require('base').setup {
        integrations = {
          'builtin.defaults',
          'builtin.git',
          'builtin.lsp',
          -- 'builtin.semantic',
          'builtin.syntax',
          'builtin.treesitter',
          'plugin.cmp',
          'plugin.devicons',
          -- 'plugin.fzf-lua',
          -- 'plugin.indent-blankline',
          'plugin.luasnip',
          'plugin.mason',
          'plugin.mini',
          'plugin.neo-tree',
          -- 'plugin.neorg',
          'plugin.telescope',
          'plugin.trouble',
          ---@diagnostic disable-next-line: assign-type-mismatch
          {
            highlights = function(_, colors)
              return {
                -- Alpha
                NeovimDashboardLogo1 = { fg = colors.blue },
                NeovimDashboardLogo2 = { fg = colors.green, bg = colors.blue },
                NeovimDashboardLogo3 = { fg = colors.green },
                -- Flash
                FlashLabel = { fg = colors.pink, bold = true },
                FlashMatch = { italic = true },
              }
            end,
            after = function(theme, colors)
              local lib = require 'heirline-components.all'

              local opts = {
                opts = {},
                statuscolumn = { -- UI left column
                  init = function(self)
                    self.bufnr = vim.api.nvim_get_current_buf()
                  end,
                  lib.component.numbercolumn(),
                  lib.component.signcolumn(),
                } or nil,
                statusline = { -- UI statusbar
                  lib.component.mode(),
                  wrap_component(lib.component.git_branch, colors.green, {}, lib.condition.is_git_repo),
                  wrap_component(lib.component.file_info, theme.base01),
                  wrap_component(lib.component.git_diff, colors.orange, {}, lib.condition.git_changed),
                  wrap_component(lib.component.diagnostics, colors.green, {}, lib.condition.has_diagnostics),
                  lib.component.fill {
                    hl = 'Normal',
                  },
                  wrap_component(lib.component.cmd_info, colors.red, {}, function()
                    return lib.condition.is_hlsearch() or lib.condition.is_macro_recording() or lib.condition.is_statusline_showcmd()
                  end),

                  lib.component.fill {
                    hl = 'Normal',
                  },
                  wrap_component(
                    lib.component.lsp,
                    colors.pink,
                    { lsp_progress = false, lsp_client_names = { truncate = 0.33, integrations = { null_ls = false, conform = false, lint = false } } }
                  ),
                  -- lib.component.compiler_state(),
                  wrap_component(lib.component.nav, colors.teal),
                  -- lib.component.mode { surround = { separator = 'right' } },
                },
                winbar = { -- UI breadcrumbs bar
                  hl = { bg = theme.base0C },
                  init = function(self)
                    self.bufnr = vim.api.nvim_get_current_buf()
                  end,
                  fallthrough = false,
                  -- lib.component.breadcrumbs_when_inactive(),
                  lib.component.breadcrumbs { hl = 'Normal' },
                },
              }

              local heirline = require 'heirline'
              local heirline_components = require 'heirline-components.all'

              -- Setup
              heirline_components.init.subscribe_to_events()
              heirline.load_colors { bg = theme.base0C }
              heirline.setup(opts)
            end,
          },
        },
      }

      vim.cmd 'colorscheme base-onedark'
    end,
  },
}
