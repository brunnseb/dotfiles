return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            vtsls = {
              experimental = {
                completion = {
                  entriesLimit = 30,
                },
              },
            },
            typescript = {
              format = { enable = false },
              preferences = {
                useAliasesForRenames = false,
                preferTypeOnlyAutoImports = true,
              },
              tsserver = {
                maxTsServerMemory = 8192,
                experimental = {
                  enableProjectDiagnostics = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
