local function on_file_remove(args)
  local vtsls_clients = vim.lsp.get_active_clients { name = "vtsls" }
  for _, vtsls_client in ipairs(vtsls_clients) do
    vtsls_client.notify("workspace/didRenameFiles", {
      files = {
        {
          oldUri = vim.uri_from_fname(args.source),
          newUri = vim.uri_from_fname(args.destination),
        },
      },
    })
  end
end

return {
  {
    "enddeadroyal/symbols-outline.nvim",

    opts = {
      highlight_hovered_item = true,
      show_guides = true,
      auto_preview = false,
      position = "right",
      relative_width = true,
      width = 25,
      auto_close = false,
      show_numbers = false,
      show_relative_numbers = false,
      show_symbol_details = true,
      preview_bg_highlight = "Pmenu",
      autofold_depth = 1,
      auto_unfold_hover = true,
      fold_markers = { "", "" },
      wrap = false,
      winblend = 2,
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "H",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "W",
        unfold_all = "E",
        fold_reset = "R",
      },
      lsp_blacklist = {},
      symbol_blacklist = {},
      symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "𝓒", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "🔐", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "🗲", hl = "@type" },
        Operator = { icon = "+", hl = "@operator" },
        TypeParameter = { icon = "𝙏", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
      },
    },
    branch = "bugfix/symbol-hover-misplacement",
    event = "User AstroFile",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      local events = require "neo-tree.events"
      opts.event_handlers = {
        {
          event = events.FILE_MOVED,
          handler = on_file_remove,
        },
        {
          event = events.FILE_RENAMED,
          handler = on_file_remove,
        },
      }
    end,
  },
  {
    "dmmulroy/tsc.nvim",
    ft = "typescript",
    event = "User AstroFile",
    config = function()
      require("tsc").setup {
        flags = {
          build = true,
        },
      }
    end,
  },
  {
    "yioneko/nvim-vtsls",
    event = "User AstroFile",
  },
  {
    url = "https://gitlab.com/szsolt7/sonarlint.nvim",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    opts = {
      server = {
        cmd = {
          "sonarlint-language-server",
          -- Ensure that sonarlint-language-server uses stdio channel
          "-stdio",
          "-analyzers",
          -- paths to the analyzers you need, using those for python and java in this example
          -- vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarpython.jar",
          -- vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarcfamily.jar",
          vim.fn.expand "/home/brunnseb/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjs.jar",
          -- vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarhtml.jar",
          -- vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarxml.jar",
          -- vim.fn.expand "$MASON/share/sonarlint-analyzers/sonartext.jar",
        },
      },
      filetypes = {
        -- Tested and working
        -- "python",
        -- "cpp",
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        -- "html",
        -- "xml",
      },
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = true,
    -- opts = function(_, opts)
    --   opts.ui = { kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind() }
    --
    --   return opts
    -- end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
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
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      dap.adapters.chrome = {
        type = "executable",
        command = "node",
        args = {
          os.getenv "HOME" .. "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js",
        },
      }

      dap.configurations.typescriptreact = {
        {
          name = "Launch 3000",
          type = "chrome",
          request = "launch",
          reAttach = true,
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          runtimeExecutable = "/usr/bin/chromium",
        },
        {
          name = "Launch 3001",
          type = "chrome",
          request = "launch",
          reAttach = true,
          url = "http://localhost:3001",
          webRoot = "${workspaceFolder}",
          runtimeExecutable = "/usr/bin/chromium",
        },
        {
          name = "Launch 3002",
          type = "chrome",
          request = "launch",
          reAttach = true,
          url = "http://localhost:3002",
          webRoot = "${workspaceFolder}",
          runtimeExecutable = "/usr/bin/chromium",
        },
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
