return {

  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        typescriptreact = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        javascript = { 'eslint_d' },
        scss = { 'prettierd' },
        css = { 'prettierd' },
        json = { 'prettierd' },
      },
    },
  },
}
