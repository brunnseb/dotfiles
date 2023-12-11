return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "gr", false }
      keys[#keys + 1] = { "gy", false }
      keys[#keys + 1] = { "gd", false }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
    opts = {
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
