return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      {
        'L3MON4D3/LuaSnip',
        -- install jsregexp. This is technically optional, but is required for 1:1 parity with VSCode snippets.
        -- Read more about the impacts of the need for jsregexp with LuaSnip [here](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#transformations)
        build = 'make install_jsregexp',
        config = function()
          require('luasnip.loaders.from_vscode').load { paths = { '/home/brunnseb/.config/nvim/lua/snippets' } } -- load snippets paths
        end,
      },
    },
    event = 'InsertEnter',
    opts = function()
      local cmp_status_ok, cmp = pcall(require, 'cmp')
      if not cmp_status_ok then
        return
      end

      local check_backspace = function()
        local col = vim.fn.col '.' - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
      end

      local kind_icons = {
        Text = '󰦨 ',
        Method = ' ',
        Function = '󰡱 ',
        Constructor = '󱁤 ',
        Field = ' ',
        Variable = ' ',
        Class = ' ',
        Interface = ' ',
        Module = '󱒌 ',
        Property = ' ',
        Unit = ' ',
        Value = 'v',
        Enum = ' ',
        Keyword = ' ',
        Snippet = ' ',
        Color = ' ',
        File = ' ',
        Reference = ' ',
        Folder = ' ',
        EnumMember = ' ',
        Constant = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
      }

      cmp.setup {
        snippet = {
          expand = function() end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          ['<CR>'] = cmp.mapping.confirm {
            -- this is the important line for Copilot
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = ({
              nvim_lsp = '',
              nvim_lua = '',
              buffer = '',
              path = '',
              emoji = '',
            })[entry.source.name]
            return vim_item
          end,
        },
        sources = {
          { name = 'nvim_lsp', max_item_count = 10 },
          { name = 'nvim_lua', max_item_count = 3 },
          { name = 'luasnip', max_item_count = 3 },
          { name = 'buffer', max_item_count = 3 },
          { name = 'path', max_item_count = 3 },
        },
        confirm_opts = {
          select = false,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        ghost_text = {
          hl_group = 'Comment',
        },
      }
    end,
  },
}
