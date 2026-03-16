local ft_js = {
  "tsx",
  "jsx",
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
}

return {
  {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    lazy = false,
    keys = {
      {
        "gR",
        "<cmd>TSToolsFileReferences<cr>",
        ft = ft_js,
        desc = "TSTools: File References",
        buffer = true,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "neovim/nvim-lspconfig",
        dependencies = {
          { "b0o/SchemaStore.nvim" },
        },
        opts = function(_, opts)
          opts.servers = opts.servers or {}
          opts.servers.ts_ls = { enabled = false }
          opts.servers.tsserver = { enabled = false } -- @deprecated

          opts.servers["*"] = opts.servers["*"] or {}
          opts.servers["*"].keys = opts.servers["*"].keys or {}

          table.insert(opts.servers["*"].keys, {
            "<leader>cR",
            function()
              if vim.tbl_contains(ft_js, vim.bo.filetype) then
                vim.cmd("TSToolsRenameFile")
              else
                vim.lsp.buf.rename()
              end
            end,
            desc = "Rename File",
            has = "rename",
          })

          opts.setup = opts.setup or {}
          opts.setup.tsserver = function()
            -- disable tsserver
            return true
          end
          opts.setup.ts_ls = function()
            -- disable ts_ls
            return true
          end

          return opts
        end,
      },
    },
    ft = ft_js,
    opts = {
      settings = {
        code_lens = "off",
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        tsserver_path = nil,
        tsserver_max_memory = 32000,
        tsserver_format_options = {
          allowIncompleteCompletions = false,
        },
        tsserver_file_preferences = {
          completions = { completeFunctionCalls = false },
          includeInlayParameterNameHints = "none",
          includeCompletionsForModuleExports = true,
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
          importModuleSpecifierPreference = "project-relative",
          jsxAttributeCompletionStyle = "braces",
        },
        tsserver_locale = "en",
        disable_member_code_lens = true,
        jsx_close_tag = { enable = false },
      },
      root_dir = function(bufnr, onDir)
        onDir(vim.fs.root(0, ".git"))
      end,
    },
  },
  {
    "dmmulroy/tsc.nvim",
    opts = {
      auto_start_watch_mode = false,
      use_trouble_qflist = false,
      flags = {
        watch = false,
      },
    },
    keys = {
      { "<leader>cttc", ft = { "typescript", "typescriptreact" }, "<cmd>TSC<cr>", desc = "Type Check" },
      { "<leader>cttq", ft = { "typescript", "typescriptreact" }, "<cmd>TSCOpen<cr>", desc = "Type Check Quickfix" },
    },
    ft = {
      "typescript",
      "typescriptreact",
    },
    cmd = {
      "TSC",
      "TSCOpen",
      "TSCClose",
    },
  },
}
