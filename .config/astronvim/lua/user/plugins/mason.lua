local null_ls = require "null-ls"

local vtsls_code_actions = {
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  generator = {
    fn = function(context)
      return {
        {
          title = "󰛦  Add missing imports",
          action = function() vim.api.nvim_buf_call(context.bufnr, require("vtsls").commands.add_missing_imports) end,
        },
        {
          title = "󰛦  Organize imports",
          action = function() vim.api.nvim_buf_call(context.bufnr, require("vtsls").commands.organize_imports) end,
        },
        {
          title = "󰛦  Removed unused",
          action = function() vim.api.nvim_buf_call(context.bufnr, require("vtsls").commands.remove_unused) end,
        },
        {
          title = "󰛦  Go to source definition",
          action = function() vim.api.nvim_buf_call(context.bufnr, require("vtsls").commands.goto_source_definition) end,
        },
        {
          title = "󰛦  Restart tsserver",
          action = function() vim.api.nvim_buf_call(context.bufnr, require("vtsls").commands.restart_tsserver) end,
        },
        {
          title = "󰛦  Rename file",
          action = function() vim.api.nvim_buf_call(context.bufnr, require("vtsls").commands.rename_file) end,
        },
        {
          title = "󰛦  File references",
          action = function() vim.api.nvim_buf_call(context.bufnr, require("vtsls").commands.file_references) end,
        },
      }
    end,
  },
}

null_ls.register(vtsls_code_actions)

-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        "bashls",
        "jsonls",
        "cssls",
        "tailwindcss",
        "vtsls",
        -- "tsserver",
        "yamlls",
        "eslint",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = { "stylua", "prettierd" },
      automatic_installation = false,
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = { "chrome" },
    },
  },
}
