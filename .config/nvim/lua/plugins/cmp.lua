return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'windwp/nvim-autopairs',
      {
        'L3MON4D3/LuaSnip',
        -- install jsregexp. This is technically optional, but is required for 1:1 parity with VSCode snippets.
        -- Read more about the impacts of the need for jsregexp with LuaSnip [here](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#transformations)
        build = 'make install_jsregexp',
        dependencies = { { 'rafamadriz/friendly-snippets' } },
        config = function()
          require('luasnip.loaders.from_vscode').load {
            paths = { '/home/brunnseb/.config/nvim/lua/snippets', '/home/brunnseb/.local/share/nvim/lazy/friendly-snippets/' },
          } -- load snippets paths
        end,
      },
      {
        'luckasRanarison/tailwind-tools.nvim',
        opts = {
          document_color = {
            inline_symbol = '⏺ ',
          },
          conceal = {
            enabled = true,
          },
        },
      },
      'onsails/lspkind-nvim',
    },
    event = 'InsertEnter',
    keys = {
      {
        '<tab>',
        function()
          return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
        end,
        expr = true,
        silent = true,
        mode = 'i',
      },
      {
        '<tab>',
        function()
          require('luasnip').jump(1)
        end,
        mode = 's',
      },
      {
        '<s-tab>',
        function()
          require('luasnip').jump(-1)
        end,
        mode = { 'i', 's' },
      },
    },
    opts = function()
      local cmp_status_ok, cmp = pcall(require, 'cmp')
      if not cmp_status_ok then
        return
      end

      cmp.setup {
        enabled = true,
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
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
        },
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = require('lspkind').cmp_format {
            mode = 'symbol',
            preset = 'codicons',
            before = require('tailwind-tools.cmp').lspkind_format,
          },
        },
        sources = {
          { name = 'nvim_lsp', max_item_count = 10 },
          { name = 'luasnip', max_item_count = 3 },
          { name = 'buffer', max_item_count = 3 },
          { name = 'path', max_item_count = 3 },
        },
        -- confirm_opts = {
        --   select = false,
        -- },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        ghost_text = {
          hl_group = 'Comment',
        },
      }

      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
}
