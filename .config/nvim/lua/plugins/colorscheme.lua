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
          'builtin.semantic',
          'builtin.syntax',
          'builtin.treesitter',
          'plugin.cmp',
          'plugin.devicons',
          'plugin.luasnip',
          'plugin.mason',
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
                -- Multi Cursor
                VM_Mono = { bg = colors.orange, fg = colors.black, italic = true },
                VM_Extend = { bg = colors.orange, fg = colors.black, italic = true },
                VM_Insert = { bg = colors.orange, fg = colors.black },
              }
            end,
            after = function(theme, colors)
              local lib = require 'heirline-components.all'

              local wrap_component = function(component, color, opts, condition)
                local left = {
                  provider = '',
                  hl = { fg = color, bg = colors.bg_statusline },
                  condition = condition,
                }
                local right = {
                  provider = '',
                  hl = { fg = color, bg = colors.bg_statusline },
                  condition = condition,
                }
                local separator = {
                  provider = ' ',
                  hl = { bg = colors.bg_statusline },
                }

                return {
                  left,
                  component(vim.tbl_deep_extend('force', { surround = { separator = 'none', color = color } }, opts or {})),
                  right,
                  separator,
                }
              end

              local function OverseerTasksForStatus(status)
                return function(opts)
                  return vim.tbl_deep_extend('force', {
                    condition = function(self)
                      return self.tasks[status]
                    end,
                    provider = function(self)
                      return string.format('%s%d', self.symbols[status], #self.tasks[status])
                    end,
                  }, opts)
                end
              end

              local Overseer = {
                condition = function()
                  return package.loaded.overseer
                end,
                init = function(self)
                  local tasks = require('overseer.task_list').list_tasks { unique = true }
                  local tasks_by_status = require('overseer.util').tbl_group_by(tasks, 'status')
                  self.tasks = tasks_by_status
                end,
                static = {
                  symbols = {
                    ['CANCELED'] = ' ',
                    ['FAILURE'] = '󰅚 ',
                    ['SUCCESS'] = '󰄴 ',
                    ['RUNNING'] = '󰑮 ',
                  },
                },

                wrap_component(OverseerTasksForStatus 'CANCELED', colors.grey, { hl = { bg = colors.grey, fg = colors.white } }, function(self)
                  return self.tasks['CANCELED']
                end),
                wrap_component(OverseerTasksForStatus 'RUNNING', colors.orange, { hl = { bg = colors.orange, fg = colors.bg_statusline } }, function(self)
                  return self.tasks['RUNNING']
                end),
                wrap_component(OverseerTasksForStatus 'SUCCESS', colors.green, { hl = { bg = colors.green, fg = colors.bg_statusline } }, function(self)
                  return self.tasks['SUCCESS']
                end),
                wrap_component(OverseerTasksForStatus 'FAILURE', colors.red, { hl = { bg = colors.red, fg = colors.bg_statusline } }, function(self)
                  return self.tasks['FAILURE']
                end),
              }

              local opts = {
                opts = {},
                statuscolumn = { -- UI left column
                  init = function(self)
                    self.bufnr = vim.api.nvim_get_current_buf()
                  end,
                  lib.component.numbercolumn(),
                  lib.component.signcolumn(),
                } or nil,
                statusline = {
                  fallthrough = false,
                  {
                    condition = function()
                      return lib.condition.buffer_matches({
                        buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'terminal' },
                        filetype = { '^git.*', 'fugitive', 'aerial', 'OverseerList' },
                      }, vim.api.nvim_get_current_buf())
                    end,
                    lib.component.fill {
                      hl = { bg = colors.bg_statusline },
                    },
                    wrap_component(lib.component.file_info, theme.base02, { hl = { fg = theme.base07, italic = true } }),
                    lib.component.fill {
                      hl = { bg = colors.bg_statusline },
                    },
                  },
                  { -- UI statusbar
                    lib.component.mode { hl = { bg = colors.bg_statusline } },
                    wrap_component(lib.component.git_branch, theme.base02, { hl = { fg = theme.base09, bold = true } }, lib.condition.is_git_repo),
                    wrap_component(lib.component.file_info, theme.base02, { hl = { fg = theme.base07, italic = true } }),
                    wrap_component(lib.component.git_diff, theme.base02, {}, lib.condition.git_changed),
                    wrap_component(lib.component.diagnostics, theme.base02, {}, lib.condition.has_diagnostics),
                    lib.component.fill {
                      hl = { bg = colors.bg_statusline },
                    },
                    wrap_component(lib.component.cmd_info, colors.pink, {}, function()
                      return lib.condition.is_hlsearch() or lib.condition.is_macro_recording() or lib.condition.is_statusline_showcmd()
                    end),
                    lib.component.fill {
                      hl = { bg = colors.bg_statusline },
                    },
                    Overseer,
                    wrap_component(
                      lib.component.lsp,
                      colors.dark_purple,
                      { lsp_progress = false, lsp_client_names = { truncate = 0.33, integrations = { null_ls = false, conform = false, lint = false } } }
                    ),
                    -- lib.component.compiler_state(),
                    wrap_component(lib.component.nav, colors.teal),
                    -- lib.component.mode { surround = { separator = 'right' } },
                  },
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

      vim.cmd 'colorscheme base-bearded-arc'
    end,
  },
}
