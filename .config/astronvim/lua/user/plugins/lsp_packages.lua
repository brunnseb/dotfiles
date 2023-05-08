return {
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function() require("lspsaga").setup {} end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    opts = {
      inlay_hints = {
        parameter_hints = {
          show = true,
          prefix = " ◀ ",
          separator = ", ",
          remove_colon_start = false,
          remove_colon_end = true,
        },
        type_hints = {
          -- type and other hints
          show = true,
          prefix = "   ",
          separator = ", ",
          remove_colon_start = true,
          remove_colon_end = true,
        },
        only_current_line = false,
        -- separator between types and parameter hints. Note that type hints are
        -- shown before parameter
        labels_separator = "  ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- highlight group
        highlight = "LspInlayHint",
      },
      enabled_at_startup = true,
      debug_mode = false,
    },
  },
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      -- use codicons preset
      opts.preset = "codicons"
      -- set some missing symbol types
      opts.symbol_map = {
        Array = "",
        Boolean = "",
        Key = "",
        Namespace = "",
        Null = "",
        Number = "",
        Object = "",
        Package = "",
        String = "",
      }

      opts.before = function(entry, vim_item)
        vim_item.menu = ({
          buffer = "[Buf]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[API]",
          cmp_tabnine = "[Tabnine]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end

      return opts
    end,
  },
  { "Pocco81/DAPInstall.nvim" },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      dap.adapters.firefox = {
        type = "executable",
        command = "node",
        args = { os.getenv "HOME" .. "/path/to/vscode-firefox-debug/dist/adapter.bundle.js" },
      }

      dap.configurations.typescriptreact = {

        {
          name = "Chrome attach",
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
          skipFiles = { "node_modules/**/*", "**/*.mjs", "**/*.cjs", "**/*.d.ts" },
        },
      }
    end,
  },
}
