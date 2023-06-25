return {
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
    opts = function(_, opts)
      opts.ui = { kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind() }

      return opts
    end,
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
