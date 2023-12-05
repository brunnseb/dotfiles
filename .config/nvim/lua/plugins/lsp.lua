return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
        tailwindcss = function()
          require("lazyvim.util").lsp.on_attach(function(client, bufnr)
            if client.server_capabilities.colorProvider then
              require("lsp/utils/documentcolors").buf_attach(bufnr)
              require("colorizer").attach_to_buffer(
                bufnr,
                { mode = "background", css = true, names = false, tailwind = false }
              )
            end
          end)
        end,
      },
    },
  },
}
