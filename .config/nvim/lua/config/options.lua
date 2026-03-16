-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.matchparen_timeout = 2
vim.g.matchparen_insert_timeout = 2

vim.opt.syntax = "off"
vim.o.spell = false
vim.o.foldenable = false

vim.g.snacks_animate = false
vim.lsp.log.set_level("off")
