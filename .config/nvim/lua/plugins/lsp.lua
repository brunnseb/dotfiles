return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          settings = {
            format = false,
          },
        },
      },
      setup = {
        eslint = function()
          local base_on_attach = vim.lsp.config.eslint.on_attach
          vim.lsp.config("eslint", {
            on_attach = function(client, bufnr)
              if not base_on_attach then
                return
              end

              base_on_attach(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "LspEslintFixAll",
              })
            end,
          })
        end,
      },
    },
  },
}
