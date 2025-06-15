-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del({ "n" }, "<leader>l")

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set(
  { "n", "t", "c" },
  "<C-Left>",
  "<cmd>SmartCursorMoveLeft<CR>",
  { desc = "Go to Left Window", remap = true }
)
vim.keymap.set(
  { "n", "t", "c" },
  "<C-Right>",
  "<cmd>SmartCursorMoveRight<CR>",
  { desc = "Go to Right Window", remap = true }
)
vim.keymap.set(
  { "n", "t", "c" },
  "<C-Down>",
  "<cmd>SmartCursorMoveDown<CR>",
  { desc = "Go to Lower Window", remap = true }
)
vim.keymap.set({ "n", "t", "c" }, "<C-Up>", "<cmd>SmartCursorMoveUp<CR>", { desc = "Go to Upper Window", remap = true })

vim.keymap.set({ "n", "t", "c" }, "<A-Up>", "<cmd>SmartResizeUp<cr>", { desc = "Increase Window Height", remap = true })
vim.keymap.set(
  { "n", "t", "c" },
  "<A-Down>",
  "<cmd>SmartResizeDown<cr>",
  { desc = "Decrease Window Height", remap = true }
)
vim.keymap.set(
  { "n", "t", "c" },
  "<A-Left>",
  "<cmd>SmartResizeLeft<cr>",
  { desc = "Decrease Window Width", remap = true }
)
vim.keymap.set(
  { "n", "t", "c" },
  "<A-Right>",
  "<cmd>SmartResizeRight<cr>",
  { desc = "Increase Window Width", remap = true }
)

vim.keymap.set("n", "<leader>su", "<cmd>TimeMachineToggle<CR>", { desc = "TimeMachine" })
