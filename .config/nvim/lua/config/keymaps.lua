-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del({ "n" }, "<leader>l")

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-Left>", "<cmd>SmartCursorMoveLeft<CR>", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-Down>", "<cmd>SmartCursorMoveDown<CR>", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-Up>", "<cmd>SmartCursorMoveUp<CR>", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-Right>", "<cmd>SmartCursorMoveRight<CR>", { desc = "Go to Right Window", remap = true })

vim.keymap.set("n", "<M-Up>", "<cmd>SmartResizeUp<cr>", { desc = "Increase Window Height", remap = true })
vim.keymap.set("n", "<M-Down>", "<cmd>SmartResizeDown<cr>", { desc = "Decrease Window Height", remap = true })
vim.keymap.set("n", "<M-Left>", "<cmd>SmartResizeLeft<cr>", { desc = "Decrease Window Width", remap = true })
vim.keymap.set("n", "<M-Right>", "<cmd>SmartResizeRight<cr>", { desc = "Increase Window Width", remap = true })
