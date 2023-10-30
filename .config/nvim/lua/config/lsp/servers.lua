return {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      completion = {
        callSnippet = 'Replace',
      },
      hint = {
        enable = true,
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
