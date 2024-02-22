-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")

vim.keymap.set({ "n", "i", "v" }, "<C-Left>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set({ "n", "i", "v" }, "<C-Down>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set({ "n", "i", "v" }, "<C-Up>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set({ "n", "i", "v" }, "<C-Right>", "<C-w>l", { desc = "Go to right window", remap = true })

vim.keymap.set("n", "<S-Left>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "<leader>uc", function()
  require("utils.colorscheme").toggle()
end, { desc = "Toggle colorscheme" })

-- Wait for https://github.com/LazyVim/LazyVim/pull/2007 to get merged
-- if vim.lsp.inlay_hint then
--   vim.keymap.set("n", "<leader>uh", function()
--     if vim.lsp.inlay_hint.is_enabled() then
--       vim.lsp.inlay_hint.enable(0, false)
--     else
--       vim.lsp.inlay_hint.enable(0, true)
--     end
--   end, { desc = "Toggle Inlay Hints" })
-- end

vim.keymap.set("n", "<leader>cg", function()
  require("logsitter").log()
end)
