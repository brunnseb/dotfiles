-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Needed so current nvim instance is used to open file in lazygit
vim.api.nvim_exec(
  [[
let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
]],
  false
)
