return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      on_attach = require 'config.lsp.on_attach',
      settings = {
        tsserver_file_preferences = {
          quotePreference = 'auto',
          importModuleSpecifierEnding = 'auto',
          jsxAttributeCompletionStyle = 'auto',
          allowTextChangesInNewFiles = true,
          providePrefixAndSuffixTextForRename = true,
          allowRenameOfImportPath = true,
          includeAutomaticOptionalChainCompletions = true,
          provideRefactorNotApplicableReason = true,
          generateReturnInDocTemplate = true,
          includeCompletionsForImportStatements = true,
          includeCompletionsWithSnippetText = true,
          includeCompletionsWithClassMemberSnippets = true,
          includeCompletionsWithObjectLiteralMethodSnippets = true,
          useLabelDetailsInCompletionEntries = true,
          allowIncompleteCompletions = true,
          displayPartsForJSDoc = true,
          disableLineTextInReferences = true,
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        tsserver_format_options = {
          insertSpaceAfterCommaDelimiter = true,
          insertSpaceAfterConstructor = false,
          insertSpaceAfterSemicolonInForStatements = true,
          insertSpaceBeforeAndAfterBinaryOperators = true,
          insertSpaceAfterKeywordsInControlFlowStatements = true,
          insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
          insertSpaceBeforeFunctionParenthesis = false,
          insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
          insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
          insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
          insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
          insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
          insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
          insertSpaceAfterTypeAssertion = false,
          placeOpenBraceOnNewLineForFunctions = false,
          placeOpenBraceOnNewLineForControlBlocks = false,
          semicolons = 'ignore',
          indentSwitchCase = true,
        },
      },
    },
  },
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
      require('neodev').setup {
        library = {
          enabled = true,
          runtime = true,
          types = true,
          plugins = false,
        },
      }
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
