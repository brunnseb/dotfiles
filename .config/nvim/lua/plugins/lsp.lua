return {
  {
    "glepnir/lspsaga.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, opts)
      opts.rename = {
        quit = "<esc>",
      }
    end,
  },
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
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] =
        { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
      keys[#keys + 1] = { "<leader>cD", "<cmd>Lspsaga lsp_finder<cr>", desc = "Finder" }
      keys[#keys + 1] = { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Doc" }
      keys[#keys + 1] = { "<leader>cd", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" }
      keys[#keys + 1] = { "<leader>ct", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "Type definition" }
      keys[#keys + 1] = { "<leader>cr", "<cmd>Lspsaga rename ++project<cr>", desc = "Rename", has = "rename" }
      keys[#keys + 1] = { "<leader>cl", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line diagnostics" }
      keys[#keys + 1] = { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto Definition" }
      keys[#keys + 1] = { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next Diagnostic" }
      keys[#keys + 1] = { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Previous Diagnostic" }
    end,
    dependencies = { "mrshmllow/document-color.nvim", "glepnir/lspsaga.nvim" },
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
