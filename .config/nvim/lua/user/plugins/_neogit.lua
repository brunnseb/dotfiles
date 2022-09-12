local M = {}

function M.setup()

  local status_ok, neogit = pcall(require, 'neogit')

  if not status_ok then
    return
  end

  neogit.setup({
    use_magit_keybindings = true,
    signs = {
      -- { CLOSED, OPENED }
      section = { ">", "v" },
      item = { " ", " " },
      hunk = { "", "" },
    },
    integrations = {
      diffview = true
    },
  })

end

return M
