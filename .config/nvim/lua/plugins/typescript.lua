-- local ft_js = {
--   "tsx",
--   "jsx",
--   "javascript",
--   "javascriptreact",
--   "javascript.jsx",
--   "typescript",
--   "typescriptreact",
--   "typescript.tsx",
-- }

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
        --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
        -- tsserver = {
        --   enabled = false,
        -- },
        -- ts_ls = {
        --   enabled = false,
        -- },
        -- vtsls = {
        --   enabled = false,
        -- },
        -- tsgo = {},
        eslint = {
          settings = {
            -- codeActionOnSave = {
            --   enable = true,
            --   mode = "all",
            -- },
            format = false,
          },
        },
      },
      setup = {
        eslint = function()
          local base_on_attach = vim.lsp.config.eslint.on_attach
          vim.lsp.config("eslint", {
            on_attach = function(client, bufnr)
              if not base_on_attach then
                return
              end

              base_on_attach(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "LspEslintFixAll",
              })
            end,
          })
        end,
      },
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
