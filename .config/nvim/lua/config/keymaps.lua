-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<A-left>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-down>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-up>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-right>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-left>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-down>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-up>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-right>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
