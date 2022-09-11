local M = {}

function M.setup()
  local status_ok, cmp = pcall(require, 'cmp')

  if not status_ok then
    return
  end

  cmp.setup({
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim-lua' },
    }, {
      { name = 'fuzzy_buffer' }
    }),
    mapping = cmp.mapping.preset.insert({
      ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(),{ 'i', 'c' }), 
      ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(),{ 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    }),
  })

  cmp.setup.cmdline('/', {
    sources = cmp.config.sources({
      { name = 'fuzzy_buffer' }
    }),
    mapping = cmp.mapping.preset.cmdline(),
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'fuzzy_path' }
    }, {
      { name = 'cmdline' }
    })
  })
end

return M
