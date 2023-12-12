-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Attach specific keybindings in which-key for specific filetypes
local present, _ = pcall(require, "which-key")
if not present then
  return
end
local _, pwk = pcall(require, "utils.which-key")

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*.md",
--   callback = function() pwk.attach_markdown(0) end
-- })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.ts", "*.tsx" },
  callback = function()
    pwk.attach_typescript(0)
  end,
})
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "package.json" },
--   callback = function() pwk.attach_npm(0) end
-- })
-- vim.api.nvim_create_autocmd("FileType",
--   {
--     pattern = "*",
--     callback = function()
--       if EcoVim.plugins.zen.enabled and vim.bo.filetype ~= "alpha" then
--         pwk.attach_zen(0)
--       end
--     end
--   })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*test.js", "*test.ts", "*test.tsx" },
--   callback = function() pwk.attach_jest(0) end
-- })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "spectre_panel",
  callback = function()
    pwk.attach_spectre(0)
  end,
})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "NvimTree",
--   callback = function() pwk.attach_nvim_tree(0) end
-- })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.html", "*.tsx" },
  callback = function(_)
    if not require("inline-fold.module").isHidden then
      vim.cmd("InlineFoldToggle")
    end
  end,
})
