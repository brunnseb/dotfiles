return {
  { 'luukvbaal/nnn.nvim', config = true },
  {
    'nvim-neo-tree/neo-tree.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    opts = function()
      local function on_file_remove(args)
        local vtsls_clients = vim.lsp.get_clients { name = 'vtsls' }
        for _, vtsls_client in ipairs(vtsls_clients) do
          vtsls_client.notify('workspace/didRenameFiles', {
            files = {
              {
                oldUri = vim.uri_from_fname(args.source),
                newUri = vim.uri_from_fname(args.destination),
              },
            },
          })
        end
      end

      local events = require 'neo-tree.events'

      return {
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
        },
        event_handlers = {
          {
            event = events.FILE_MOVED,
            handler = on_file_remove,
          },
          {
            event = events.FILE_RENAMED,
            handler = on_file_remove,
          },
        },
      }
    end,
  },
  { 'Mohammed-Taher/AdvancedNewFile.nvim' },
}
