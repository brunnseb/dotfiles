vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
  { import = 'plugins' },
}

require 'config.keymaps'
require 'config.options'
require 'config.autocmds'
