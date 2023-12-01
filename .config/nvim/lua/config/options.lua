-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.shortmess:append({ s = true, S = true })
vim.opt.wrapscan = true

-- Vim Multi Cursor Highlights
vim.g.VM_Mono_hl = "MultiCursorMono"
vim.g.VM_Extend_hl = "MultiCursorExtend"
vim.g.VM_Cursor_hl = "MultiCursorCursor"
vim.g.VM_Insert_hl = "MultiCursorInsert"

vim.g.VM_leader = ","
vim.g.VM_maps = {
  ["Select Cursor Down"] = ",j",
  ["Select Cursor Up"] = ",k",
  ["Add Cursor At Pos"] = ",,",
  ["Motion ,"] = ",;",
  ["Undo"] = "u",
  ["Redo"] = "<C-r>",
}
