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

return {
  {
    "enddeadroyal/symbols-outline.nvim",

    opts = require "user.config.symbols-outline-nvim",
    branch = "bugfix/symbol-hover-misplacement",
    event = "User AstroFile",
  },

  {
    "dmmulroy/tsc.nvim",
    ft = "typescript",
    event = "User AstroFile",
    opts = require "user.config.tsc-nvim",
  },
  {
    "yioneko/nvim-vtsls",
    event = "User AstroFile",
  },
  {
    url = "https://gitlab.com/szsolt7/sonarlint.nvim",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    opts = require "user.config.sonarlint-nvim",
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {
        ui = {
          kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        },
      }
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "onsails/lspkind.nvim",
    opts = require "user.config.lspkind-nvim",
  },
}
