return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        keys = { { "<leader>cn", "<cmd>Navbuddy<CR>", desc = "Navbuddy" } },
        opts = function(_, opts)
          local actions = require("nvim-navbuddy.actions")
          opts.lsp = { auto_attach = true }
          opts.mappings = {
            ["<left>"] = actions.parent(), -- Move to left panel
            ["<right>"] = actions.children(),
          }
        end,
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "gr", false }
      keys[#keys + 1] = { "gy", false }
      keys[#keys + 1] = { "gd", false }
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<leader>cd", false }
      -- keys[#keys + 1] = { "gr", vim.lsp.buf.references }
      -- keys[#keys + 1] = { "gy", vim.lsp.buf.type_definition }
      -- keys[#keys + 1] = { "gd", vim.lsp.buf.definition }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
    opts = {
      diagnostics = {
        virtual_text = false,
        virtual_lines = false,
      },
      inlay_hints = { enabled = true },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      servers = {},
      setup = {
        tailwindcss = function()
          require("lazyvim.util").lsp.on_attach(function(client, bufnr)
            if client.server_capabilities.colorProvider then
              require("lsp/utils/documentcolors").buf_attach(bufnr)
              require("colorizer").attach_to_buffer(
                bufnr,
                { mode = "background", css = true, names = false, tailwind = false }
              )
            end
          end)
        end,
      },
    },
  },
}
