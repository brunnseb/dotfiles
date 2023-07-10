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

local events = require "neo-tree.events"

return {
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
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
