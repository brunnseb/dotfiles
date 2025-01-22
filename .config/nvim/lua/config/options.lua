-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.lsp.set_log_level("off")
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  severity_sort = true,
  signs = false,
})
vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_eslint_auto_format = false
vim.g.lazyvim_blink_main = true
-- Opt
vim.opt.syntax = "off"
vim.opt.foldenable = false
vim.opt.spell = false

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
