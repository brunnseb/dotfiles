return {
  {

    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    opts = {},
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    priority = 1000,
    event = "VeryLazy", -- Or `LspAttach`
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "powerline",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
      },
      servers = {
        tailwindcss = {
          settings = {
            tailwindCSS = {
              classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
              includeLanguages = {
                eelixir = "html-eex",
                eruby = "erb",
                htmlangular = "html",
                templ = "html",
              },
              lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
              },
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                },
              },
              validate = true,
            },
          },
        },
        vtsls = {
          settings = {
            complete_function_calls = false,
            typescript = {
              preferences = {
                useAliasesForRenames = false,
                importModuleSpecifier = "shortest",
                importModuleSpecifierEndingt = "minimal",
              },
              suggest = {
                completeFunctionCalls = true,
              },
            },
            javascript = {
              preferences = {
                useAliasesForRenames = false,
                importModuleSpecifier = "relative",
                importModuleSpecifierEndingt = "minimal",
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
