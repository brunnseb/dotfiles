-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")

vim.keymap.set('n', '<leader>uc', function()
  require('utils.colorscheme').toggle()
end, { desc = 'Toggle colorscheme' })

-- Wait for https://github.com/LazyVim/LazyVim/pull/2007 to get merged
if vim.lsp.inlay_hint then
  vim.keymap.set("n", "<leader>uh", function()
    if vim.lsp.inlay_hint.is_enabled() then
      vim.lsp.inlay_hint.enable(0, false)
    else
      vim.lsp.inlay_hint.enable(0, true)
    end
  end, { desc = "Toggle Inlay Hints" })
end

vim.keymap.set("n", "<leader>cg", function()
  require("logsitter").log()
end)

vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep_args<CR>", { desc = "Grep" })
vim.keymap.set("n", "<leader>ff", function()
  local git_repo = vim.fn.system("git rev-parse --show-toplevel 2> /dev/null")
  if git_repo == nil then
    require("telescope.builtin").find_files()
  else
    require("telescope.builtin").git_files()
  end
end, { desc = "Find files" })
