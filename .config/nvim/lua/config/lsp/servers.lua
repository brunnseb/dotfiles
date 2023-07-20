return {
  eslint = {},
  vtsls = {
    typescript = {
      inlayHints = {
        parameterNames = {
          enabled = 'all',
          suppressWhenArgumentMatchesName = false,
        },
        parameterTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = true,
          suppressWhenTypeMatchesName = false,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        enumMemberValues = {
          enabled = true,
        },
      },
      suggest = {
        completeFunctionCalls = true,
      },
      preferences = {
        importModuleSpecifier = 'relative',
        renameShorthandProperties = false,
        useAliasesForRenames = false,
      },
      updateImportsOnFileMove = 'always',
      tsserver = {
        maxTsServerMemory = 8192,
        experimental = {
          enableProjectDiagnostics = true,
        },
      },
      preferGoToSourceDefinition = true,
    },
    javascript = {
      inlayHints = {
        parameterNames = {
          enabled = 'all',
          suppressWhenArgumentMatchesName = false,
        },
        parameterTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = true,
          suppressWhenTypeMatchesName = false,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        enumMemberValues = {
          enabled = true,
        },
      },
      suggest = {
        completeFunctionCalls = true,
      },
      preferences = {
        importModuleSpecifier = 'relative',
        renameShorthandProperties = false,
        useAliasesForRenames = false,
      },
      updateImportsOnFileMove = 'always',
      tsserver = {
        maxTsServerMemory = 8192,
        experimental = {
          enableProjectDiagnostics = true,
        },
      },
      preferGoToSourceDefinition = true,
    },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
  cssls = {
    scss = {
      lint = {
        unknownAtRules = 'ignore',
      },
    },
  },
  jsonls = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
  yamlls = {
    yaml = {
      schemaStore = {
        enable = false,
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
  tailwindcss = {},
}
