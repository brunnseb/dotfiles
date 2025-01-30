return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = {
      servers = {
        vtsls = {
          settings = {
            complete_function_calls = false,
            typescript = {
              preferences = {
                useAliasesForRenames = false,
              },
              suggest = {
                completeFunctionCalls = true,
              },
            },
          },
        },
        cssls = {
          settings = {
            css = { validate = true, lint = {
              unknownAtRules = "ignore",
            } },
            scss = { validate = true, lint = {
              unknownAtRules = "ignore",
            } },
            less = { validate = true, lint = {
              unknownAtRules = "ignore",
            } },
          },
        },
      },
    },
  },
}
