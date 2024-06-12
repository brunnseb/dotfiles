return {
  {
    'luckasRanarison/tailwind-tools.nvim',
    event = 'InsertEnter',
    opts = {
      document_color = {
        inline_symbol = '⏺ ',
      },
      conceal = {
        enabled = true,
      },
    },
  },
  {
    'L3MON4D3/LuaSnip',
    -- install jsregexp. This is technically optional, but is required for 1:1 parity with VSCode snippets.
    -- Read more about the impacts of the need for jsregexp with LuaSnip [here](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#transformations)
    build = 'make install_jsregexp',
    dependencies = { { 'rafamadriz/friendly-snippets' } },
    event = 'InsertEnter',
    config = function()
      require('luasnip.loaders.from_vscode').load {
        paths = { '/home/brunnseb/.config/nvim/lua/snippets', '/home/brunnseb/.local/share/nvim/lazy/friendly-snippets/' },
      } -- load snippets paths
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind-nvim',
      'rcarriga/cmp-dap',
      -- 'windwp/nvim-autopairs',
    },
    event = 'InsertEnter',
    version = false,
    opts = function()
      -- ensure dependencies exist
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      -- border opts
      local border_opts = {
        border = 'rounded',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
      }

      cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
        sources = {
          { name = 'dap' },
        },
      })

      return {

        enabled = function()
          return vim.api.nvim_get_option_value('buftype', { buf = 0 }) ~= 'prompt' or require('cmp_dap').is_dap_buffer()
        end,
        preselect = cmp.PreselectMode.None,

        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            preset = 'codicons',
            before = require('tailwind-tools.cmp').lspkind_format,
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        duplicates = {
          nvim_lsp = 1,
          luasnip = 1,
          buffer = 1,
          path = 1,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },
        mapping = {
          ['<C-k>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-j>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<S-CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<C-CR>'] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
          { name = 'buffer', priority = 500 },
          { name = 'path', priority = 250 },
        },
      }
    end,
  },
}
