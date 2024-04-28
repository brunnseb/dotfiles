return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'dmmulroy/ts-error-translator.nvim' },
    opts = function(_, opts)
      local baseDefinitionHandler = vim.lsp.handlers['textDocument/definition']
      local filter = require('utils.filter').filter
      local filterReactDTS = require('utils.filter').filterReactDTS

      local handlers = {
        ['textDocument/definition'] = function(err, result, method, ...)
          if vim.islist(result) and #result > 1 then
            local filtered_result = filter(result, filterReactDTS)
            return baseDefinitionHandler(err, filtered_result, method, ...)
          end

          baseDefinitionHandler(err, result, method, ...)
        end,
        -- ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        --   underline = true,
        --   virtual_text = {
        --     spacing = 5,
        --     min = 'Warning',
        --   },
        --   update_in_insert = true,
        -- }),
        ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
          require('ts-error-translator').translate_diagnostics(err, result, ctx, config)
          vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
      }

      opts.handlers = handlers
      opts.settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'all',
          includeCompletionsForModuleExports = true,
        },
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = true,
        },
      }
    end,
  },
}
