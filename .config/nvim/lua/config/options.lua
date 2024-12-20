-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.lsp.set_log_level("off")

-- Opt
vim.opt.syntax = "off"
vim.opt.foldenable = false
vim.opt.spell = false

-- Global
vim.g.matchparen_timeout = 2
vim.g.matchparen_insert_timeout = 2

-- blink.cmp
vim.g.lazyvim_blink_main = true

-- Vim Multi Cursor Highlights
vim.g.VM_Mono_hl = "MultiCursorMono"
vim.g.VM_Extend_hl = "MultiCursorExtend"
vim.g.VM_Cursor_hl = "MultiCursorCursor"
vim.g.VM_Insert_hl = "MultiCursorInsert"

vim.g.VM_leader = ","
vim.g.VM_maps = {
  ["Add Cursor Down"] = ",<Down>",
  ["Add Cursor Up"] = ",<Up>",
  ["Add Cursor At Pos"] = ",,",
  ["Motion ,"] = ",;",
  ["Undo"] = "u",
  ["Redo"] = "<C-r>",
}
