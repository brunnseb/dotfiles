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
        virtual_text = true,
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
      servers = {
        -- vtsls = {
        --   settings = {
        --     typescript = {
        --       inlayHints = {
        --         parameterNames = { enabled = "literals" },
        --         parameterTypes = { enabled = true },
        --         variableTypes = { enabled = true },
        --         propertyDeclarationTypes = { enabled = true },
        --         functionLikeReturnTypes = { enabled = true },
        --         enumMemberValues = { enabled = true },
        --       },
        --       -- referencesCodeLens = { enabled = true, showOnAllFunctions = true },
        --       -- implementationsCodeLens = { enabled = true, showOnAllFunctions = true },
        --     },
        --   },
        -- },
      },
      setup = {
        -- vtsls = function()
        --   require("lazyvim.util").lsp.on_attach(function(c, bufnr)
        --     c.server_capabilities.documentFormattingProvider = false
        --     c.server_capabilities.documentRangeFormattingProvider = false
        --     c.server_capabilities.semanticTokensProvider = nil
        --     -- local status_ok, codelens_supported = pcall(function()
        --     --   return c.supports_method("textDocument/codeLens")
        --     -- end)
        --     -- if not status_ok or not codelens_supported then
        --     --   return
        --     -- end
        --     -- local group = "lsp_code_lens_refresh"
        --     -- local cl_events = { "BufEnter", "InsertLeave" }
        --     -- local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
        --     --   group = group,
        --     --   buffer = bufnr,
        --     --   event = cl_events,
        --     -- })
        --     --
        --     -- if ok and #cl_autocmds > 0 then
        --     --   return
        --     -- end
        --     -- vim.api.nvim_create_augroup(group, { clear = false })
        --     -- vim.api.nvim_create_autocmd(cl_events, {
        --     --   group = group,
        --     --   buffer = bufnr,
        --     --   callback = vim.lsp.codelens.refresh,
        --     -- })
        --     --
        --     -- vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
        --     --   vim.notify("showReferences")
        --     --   local locations = command.arguments[3]
        --     --   local client = vim.lsp.get_client_by_id(ctx.client_id)
        --     --   if locations and #locations > 0 then
        --     --     local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
        --     --     vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
        --     --     vim.api.nvim_command("lopen")
        --     --   end
        --     -- end
        --   end)
        -- end,
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
