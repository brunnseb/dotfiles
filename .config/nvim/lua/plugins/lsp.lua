return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'BufEnter',
    config = function()
      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'
      local servers = require 'config.lsp.servers'
      local on_attach = require 'config.lsp.on_attach'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          }
        end,
        ['eslint'] = function()
          require('lspconfig').eslint.setup {
            capabilities = capabilities,
            on_attach = function(client, buffer)
              vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = buffer,
                command = 'EslintFixAll',
              })
              on_attach(client, buffer)
            end,
            settings = servers['eslint'],
          }
        end,
      }
    end,
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'yioneko/nvim-vtsls',
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
}
