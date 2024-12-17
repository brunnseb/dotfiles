---@diagnostic disable: missing-fields
---
return {
  {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        -- version = 'v2.*',
        build = 'make install_jsregexp',
        dependencies = { { 'rafamadriz/friendly-snippets' } },
        event = 'InsertEnter',
        config = function()
          require('luasnip.loaders.from_vscode').load {
            paths = { vim.fn.expand '$HOME/.config/nvim/lua/snippets', vim.fn.expand '$HOME/.local/share/nvim/lazy/friendly-snippets/' },
          }
        end,
      },
    },
    build = 'cargo build --release',
    opts = {
      keymap = {
        preset = 'super-tab',
      },
      appearance = {
        use_nvim_cmp_as_default = true,
      },
      completion = { accept = { auto_brackets = { enabled = true } } },
      snippets = {
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction)
          require('luasnip').jump(direction)
        end,
      },
      sources = {
        default = { 'lsp', 'path', 'luasnip', 'buffer' },
        cmdline = {},
        per_filetype = {
          codecompanion = { 'codecompanion', 'path' },
        },
        providers = {
          codecompanion = {
            name = 'CodeCompanion',
            module = 'codecompanion.providers.completion.blink',
            enabled = true, -- Whether or not to enable the provider
          },
          luasnip = {
            name = 'Luasnip',
            module = 'blink.cmp.sources.luasnip',
            enabled = true,
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
