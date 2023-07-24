return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '●',
        },
        severity_sort = true,
      },
    },
    config = function(_, opts)
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

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        -- Default handler
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
        -- ESlint
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
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = false, dependencies = { 'nvim-lspconfig' } },
      { 'folke/neodev.nvim', opts = {} },
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
