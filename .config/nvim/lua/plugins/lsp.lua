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
      local nvim_lsp = require 'lspconfig'

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- vim.lsp.commands['editor.action.showReferences'] = function(command, ctx)
      --   local locations = command.arguments[3]
      --   local client = vim.lsp.get_client_by_id(ctx.client_id)
      --   if locations and #locations > 0 then
      --     local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
      --     vim.fn.setloclist(0, {}, ' ', { title = 'References', items = items, context = ctx })
      --     vim.api.nvim_command 'lopen'
      --   end
      -- end

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
        -- ['eslint'] = function()
        --   require('lspconfig').eslint.setup {
        --     capabilities = capabilities,
        --     on_attach = function(client, buffer)
        --       vim.api.nvim_create_autocmd('BufWritePre', {
        --         buffer = buffer,
        --         command = 'EslintFixAll',
        --       })
        --       on_attach(client, buffer)
        --     end,
        --     settings = servers['eslint'],
        --   }
        -- end,
        ['tailwindcss'] = function()
          require('lspconfig').tailwindcss.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = nvim_lsp.util.root_pattern '.git',
            settings = servers['tailwindcss'],
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
