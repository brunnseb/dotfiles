return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'BufEnter',
    config = function()
      -- Setup neovim lua configuration
      require('neodev').setup()
      require('neoconf').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
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
          if server_name == 'jsonls' then
            capabilities.textDocument.completion.completionItem.snippetSupport = true
          end
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
      'folke/neoconf.nvim',
      'b0o/schemastore.nvim',
      {
        url = 'https://gitlab.com/szsolt7/sonarlint.nvim',
        ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        opts = {
          server = {
            cmd = {
              'sonarlint-language-server',
              -- Ensure that sonarlint-language-server uses stdio channel
              '-stdio',
              '-analyzers',
              -- paths to the analyzers you need, using those for python and java in this example
              vim.fn.expand '/home/brunnseb/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjs.jar',
            },
          },
          filetypes = {
            'javascript',
            'typescript',
            'typescriptreact',
            'javascriptreact',
          },
        },
      },
    },
  },
}
