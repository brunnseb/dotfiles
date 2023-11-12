-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Vim Visual Multi
vim.g.VM_leader = ","
vim.g.VM_maps = {
  ["Select Cursor Down"] = ",j",
  ["Select Cursor Up"] = ",k",
  ["Add Cursor At Pos"] = ",,",
  ["Motion ,"] = ",;",
  ["Undo"] = "u",
  ["Redo"] = "<C-r>",
}

vim.opt.ws = true
