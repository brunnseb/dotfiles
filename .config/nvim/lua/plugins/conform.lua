return {

  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        typescriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        javascript = { 'prettierd' },
        scss = { 'prettierd' },
        css = { 'prettierd' },
        json = { 'prettierd' },
      },
    },
  },
}
