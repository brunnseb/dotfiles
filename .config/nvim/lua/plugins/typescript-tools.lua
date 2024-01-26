return {
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local baseDefinitionHandler = vim.lsp.handlers["textDocument/definition"]

      local filter = require("lsp.utils.filter").filter
      local filterReactDTS = require("lsp.utils.filterReactDTS").filterReactDTS

      local handlers = {
        ["textDocument/definition"] = function(err, result, method, ...)
          if vim.tbl_islist(result) and #result > 1 then
            local filtered_result = filter(result, filterReactDTS)
            return baseDefinitionHandler(err, filtered_result, method, ...)
          end

          baseDefinitionHandler(err, result, method, ...)
        end,
      }

      require("typescript-tools").setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        handlers = handlers,
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
    end,
  },
}
