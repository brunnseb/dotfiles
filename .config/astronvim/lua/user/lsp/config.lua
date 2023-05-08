return {
  vtsls = require("vtsls").lspconfig,
  tsserver = {
    cmd = {
      "typescript-language-server",
      "--stdio",
      "--tsserver-path",
      "/home/brunnseb/.volta/tools/shared/typescript/lib/tsserver.js",
    },
    init_options = {
      maxTsServerMemory = 8192,
    },
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  },
  tailwindcss = {
    autostart = false,
    -- settings = {
    --   tailwindCSS = {
    --     experimental = {
    --       configFile = {
    --         ["apps/portal/tailwind.config.cjs"] = { "apps/portal/**", "apps/public-forms/**" },
    --         ["apps/cockpit/tailwind.config.cjs"] = "apps/cockpit/**",
    --         ["libs/cockpit-core/tailwind.config.cjs"] = "libs/!(portal-core)/**",
    --         ["libs/portal-core/tailwind.config.cjs"] = "libs/portal-core/**",
    --       },
    --     },
    --   },
    -- },
  },
}
