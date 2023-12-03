return {
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
  },
  {
    "gaelph/logsitter.nvim",
    event = "BufEnter",
  },
  {
    "chrisgrieser/nvim-spider",
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  {
    "axelvc/template-string.nvim",
    event = "BufEnter",
    config = true,
  },
  {
    "johmsalas/text-case.nvim",
    config = true,
  },

  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<Leader>cv", "<CMD>TWValues<CR>", desc = "Tailwind CSS values" },
    },
    opts = {
      border = "rounded",          -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "html",
        "css",
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "lua",
      },
      user_default_options = {
        mode = "background",
        tailwind = false, -- Enable tailwind colors
      },
    },
  },
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
          P(result)
          if vim.tbl_islist(result) and #result > 1 then
            local filtered_result = filter(result, filterReactDTS)
            return baseDefinitionHandler(err, filtered_result, method, ...)
          end

          baseDefinitionHandler(err, result, method, ...)
        end,
      }

      require("typescript-tools").setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
        handlers = handlers,
        settings = {
          separate_diagnostic_server = true,
          code_lens = "off",
          tsserver_file_preferences = {
            quotePreference = "auto",
            importModuleSpecifierEnding = "auto",
            jsxAttributeCompletionStyle = "auto",
            allowTextChangesInNewFiles = true,
            providePrefixAndSuffixTextForRename = true,
            allowRenameOfImportPath = true,
            includeAutomaticOptionalChainCompletions = true,
            provideRefactorNotApplicableReason = true,
            generateReturnInDocTemplate = true,
            includeCompletionsForImportStatements = true,
            includeCompletionsWithSnippetText = true,
            includeCompletionsWithClassMemberSnippets = true,
            includeCompletionsWithObjectLiteralMethodSnippets = true,
            useLabelDetailsInCompletionEntries = true,
            allowIncompleteCompletions = true,
            displayPartsForJSDoc = true,
            disableLineTextInReferences = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      })
    end,
  },
  {
    "elentok/format-on-save.nvim",
    event = "VeryLazy",
    config = function()
      local format_on_save = require("format-on-save")
      local formatters = require("format-on-save.formatters")

      format_on_save.setup({
        exclude_path_patterns = {
          "/node_modules/",
          ".local/share/nvim/lazy",
        },
        formatter_by_ft = {
          css = formatters.lsp,
          html = formatters.lsp,
          javascript = formatters.lsp,
          json = formatters.lsp,
          lua = formatters.lsp,
          markdown = formatters.prettierd,
          scss = formatters.lsp,
          sh = formatters.shfmt,
          typescript = formatters.lsp,
          typescriptreact = formatters.lsp,
          yaml = formatters.lsp,
        },

        -- Optional: fallback formatter to use when no formatters match the current filetype
        fallback_formatter = {
          formatters.remove_trailing_whitespace,
          formatters.remove_trailing_newlines,
          formatters.prettierd,
        },
      })
    end,
  },
  {
    "malbertzard/inline-fold.nvim",
    cmd = { "InlineFoldToggle" },
    opts = {
      defaultPlaceholder = "…",
      queries = {

        -- Some examples you can use
        html = {
          { pattern = 'class="([^"]*)"', placeholder = "@" }, -- classes in html
          { pattern = 'href="(.-)"' },                        -- hrefs in html
          { pattern = 'src="(.-)"' },                         -- HTML img src attribute
        },
        typescriptreact = {
          { pattern = 'className="([^"]*)"', placeholder = "@" }, -- classes in tsx
          { pattern = 'href="(.-)"' },                            -- hrefs in tsx
          { pattern = 'src="(.-)"' },                             -- HTML img src attribute
        },
      },
    },
  },
  {

    "mfussenegger/nvim-dap",
    dependencies = {
      -- "mxsdev/nvim-dap-vscode-js",
      -- {
      --   "jay-babu/mason-nvim-dap.nvim",
      --   event = "BufReadPre", -- <-- this
      --   opts = {
      --     ensure_installed = { 'dap-vscode-js' }
      --   }
      -- },
    },
    opts = function(_, opts)
      local dap = require("dap")
      local dap_utils = require("dap.utils")

      local adapters = {
        'pwa-node',
        'pwa-chrome',
      }

      for _, adapter in ipairs(adapters) do
        dap.adapters[adapter] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = {
            command = 'node',
            args = {
              require('mason-registry').get_package('js-debug-adapter'):get_install_path()
              .. '/js-debug/src/dapDebugServer.js',
              '${port}',
            },
          },
        }
      end

      -- require("dap-vscode-js").setup({
      --   debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      --   debugger_cmd = { "js-debug-adapter" },
      --   adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      -- })
      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Configurations                                           │
      -- ╰──────────────────────────────────────────────────────────╯
      local exts = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
      }


      for i, ext in ipairs(exts) do
        dap.configurations[ext] = {
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Launch Chrome with "localhost"',
            url = 'http://localhost:3000',
            -- webRoot = '${workspaceFolder}/apps/cockpit/src',
            webRoot = '${workspaceFolder}',
            runtimeExecutable = '/usr/bin/chromium',
            runtimeArgs = { '--remote-debugging-port=9222' },
            sourceMaps = true,
            skipFiles = {
              '<node_internals>/**/*.js',
              '**/node_modules/**',
            },
          },
          -- {
          --   type = "pwa-chrome",
          --   request = "launch",
          --   name = "Launch Chrome with \"localhost\"",
          --   url = "http://localhost:3000",
          --   webRoot = "${workspaceFolder}",
          -- },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node)",
            cwd = vim.fn.getcwd(),
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with ts-node)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "--loader", "ts-node/esm" },
            runtimeExecutable = "node",
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
            runtimeExecutable = "deno",
            attachSimplePort = 9229,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with jest)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
            runtimeExecutable = "node",
            args = { "${file}", "--coverage", "false" },
            rootPath = "${workspaceFolder}",
            sourceMaps = true,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with vitest)",
            cwd = vim.fn.getcwd(),
            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
            args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
            autoAttachChildProcesses = true,
            smartStep = true,
            console = "integratedTerminal",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
            runtimeExecutable = "deno",
            attachSimplePort = 9229,
          },
          {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach Program (pwa-chrome, select port)",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            port = function()
              return vim.fn.input("Select port: ", 9222)
            end,
            webRoot = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach Program (pwa-node, select pid)",
            cwd = vim.fn.getcwd(),
            processId = dap_utils.pick_process,
            skipFiles = { "<node_internals>/**" },
          },
        }
      end
    end
  }
}
