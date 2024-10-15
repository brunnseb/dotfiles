vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- put this in your main init.lua file ( before lazy setup )
vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46_cache/'

-- put this after lazy setup

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Remove as soon as https://github.com/pmizio/typescript-tools.nvim/pull/267 is merged
vim.tbl_add_reverse_lookup = function(tbl)
  for k, v in pairs(tbl) do
    tbl[v] = k
  end
end

require('lazy').setup {
  { import = 'plugins', change_detection = false },
}

require 'config.keymaps'
require 'config.options'
require 'config.autocmds'

-- -- (method 1, For heavy lazyloaders)
-- dofile(vim.g.base46_cache .. 'defaults')
-- dofile(vim.g.base46_cache .. 'statusline')
--
-- -- (method 2, for non lazyloaders) to load all highlights at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end
