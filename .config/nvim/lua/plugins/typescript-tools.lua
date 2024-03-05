return {
  {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    -- ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local baseDefinitionHandler = vim.lsp.handlers["textDocument/definition"]

      local filter = require("lsp.utils.filter").filter
      local filterReactDTS = require("lsp.utils.filterReactDTS").filterReactDTS
      local lspconfig = require("lspconfig")

      local handlers = {
        ["textDocument/definition"] = function(err, result, method, ...)
          if vim.tbl_islist(result) and #result > 1 then
            local filtered_result = filter(result, filterReactDTS)
            return baseDefinitionHandler(err, filtered_result, method, ...)
          end

          baseDefinitionHandler(err, result, method, ...)
        end,
        ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
          require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
          vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      require("typescript-tools").setup({
        capabilities,
        settings = {
          separate_diagnostic_server = false,
          code_lens = "off",
          tsserver_format_options = {
            indentSwitchCase = true,
          },
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,

            -- allowRenameOfImportPath = true,
            providePrefixAndSuffixTextForRename = false,
          },
        },
      })
      lspconfig["typescript-tools"].setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        handlers = handlers,
        filetypes = {
          "javascript",
          "js",
          "jsx",
          "ts",
          "tsx",
          "typescript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      })
    end,
  },
}
