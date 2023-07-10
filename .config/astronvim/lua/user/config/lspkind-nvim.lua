return {
  -- use codicons preset
  preset = "codicons",
  -- set some missing symbol types
  symbol_map = {
    Array = "",
    Boolean = "",
    Key = "",
    Namespace = "",
    Null = "",
    Number = "",
    Object = "",
    Package = "",
    String = "",
  },
  before = function(entry, vim_item)
    vim_item.menu = ({
      buffer = "[Buf]",
      nvim_lsp = "[LSP]",
      luasnip = "[LuaSnip]",
      nvim_lua = "[API]",
      cmp_tabnine = "[Tabnine]",
      path = "[Path]",
    })[entry.source.name]
    return vim_item
  end,
}
