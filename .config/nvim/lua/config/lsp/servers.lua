-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.

-- local prettierd = {
--   formatCommand = 'prettierd ${INPUT}',
--   formatStdin = true,
-- }
--
-- local eslint_d = {
--   lintCommand = 'eslint_d --no-color --format visualstudio --stdin',
--   lintStdin = true,
--   lintFormats = { '<text>(%l,%c): %trror %m', '<text>(%l,%c): %tarning %m' },
--   lintIgnoreExitCode = true,
--   rootMarkers = {
--     '.eslintrc',
--     '.eslintrc.cjs',
--     '.eslintrc.js',
--     '.eslintrc.json',
--     '.eslintrc.yaml',
--     '.eslintrc.yml',
--     'package.json',
--   },
-- }
--
-- local luacheck = {
--   lintCommand = 'luacheck --globals vim --codes --no-color --quiet -',
--   lintStdin = true,
--   lintFormats = { '%.%#:%l:%c: (%t%n) %m' },
--   prefix = 'luacheck',
--   rootMarkers = { '.luacheckrc' },
-- }
--
-- local stylua = {
--   formatCommand = 'stylua --color Never --search-parent-directories -',
--   formatStdin = true,
--   rootMarkers = { 'stylua.toml', '.stylua.toml' },
-- }

return {
  -- efm = {
  --   languages = {
  --     lua = {
  --       luacheck,
  --       stylua,
  --     },
  --     typescript = {
  --       eslint_d,
  --       prettierd,
  --     },
  --     typescriptreact = {
  --       eslint_d,
  --       prettierd,
  --     },
  --     json = {
  --       prettierd,
  --     },
  --     scss = {
  --       prettierd,
  --     },
  --   },
  -- },
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
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}
