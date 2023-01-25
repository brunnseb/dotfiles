return {
  { "mrshmllow/document-color.nvim", config = true },
  {

    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "typescript-language-server",
        "json-lsp",
        "tailwindcss-language-server",
        "css-lsp",
        "cssmodules-language-server",
        "eslint-lsp",
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mrshmllow/document-color.nvim" },
    opts = {
      servers = {
        tailwindcss = {
          capabilities = {
            textDocument = {
              completion = { completionItem = { snippetSupport = true } },
              colorProvider = {
                dynamicRegistration = true,
              },
            },
          },
          settings = {
            tailwindCSS = {
              experimental = {
                configFile = {
                  ["apps/portal/tailwind.config.cjs"] = { "apps/portal/**", "apps/public-forms/**" },
                  ["apps/cockpit/tailwind.config.cjs"] = "apps/cockpit/**",
                  ["libs/cockpit-core/tailwind.config.cjs"] = "libs/!(portal-core)/**",
                  ["libs/portal-core/tailwind.config.cjs"] = "libs/portal-core/**",
                },
              },
            },
          },
        },
        cssls = {
          capabilities = {
            textDocument = { completion = { completionItem = { snippetSupport = true } } },
          },
          settings = {
            scss = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
            css = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
      },
      setup = {
        tailwindcss = function()
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "tailwindcss" then
              require("document-color").buf_attach(buffer)
            end
          end)
        end,
        tsserver = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "tsserver" then
              vim.keymap.set(
                "n",
                "<leader>co",
                "<cmd>TypescriptOrganizeImports<CR>",
                { buffer = buffer, desc = "Organize Imports" }
              )
              vim.keymap.set(
                "n",
                "<leader>cR",
                "<cmd>TypescriptRenameFile<CR>",
                { desc = "Rename File", buffer = buffer }
              )
              vim.keymap.set(
                "n",
                "<leader>cu",
                "<cmd>TypescriptRemoveUnused<CR>",
                { desc = "Remove Unused", buffer = buffer }
              )
            end
          end)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
}
