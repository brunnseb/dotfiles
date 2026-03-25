-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.del("n", "<leader><leader>")

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
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader><left>", require("smart-splits").swap_buf_left, { desc = "Swap buffer left" })
vim.keymap.set("n", "<leader><leader><down>", require("smart-splits").swap_buf_down, { desc = "Swap buffer down" })
vim.keymap.set("n", "<leader><leader><up>", require("smart-splits").swap_buf_up, { desc = "Swap buffer up" })
vim.keymap.set("n", "<leader><leader><right>", require("smart-splits").swap_buf_right, { desc = "Swap buffer right" })

vim.keymap.set("n", "<leader>co", function()
  vim.lsp.buf.code_action({
    context = {
      only = { "source.organizeImports" },
      diagnostics = {},
    },
    apply = true,
  })
end, { desc = "Organize imports" })
