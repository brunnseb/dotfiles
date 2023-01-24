-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Buffers
map(
  "n",
  "<leader>,",
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 0.25 }}))<CR>"
)
map(
  "n",
  "<leader>.",
  "<cmd>lua require('telescope.builtin').find_files( require('telescope.themes').get_ivy({ cwd = vim.fn.expand('%:p:h'), layout_config = { height = 0.25 }, previewer = false }))<CR>"
)

-- Files
map("n", "<leader>fc", "<cmd>e $MYVIMRC <CR>", { desc = "Config" })
map("n", "<leader>fs", "<cmd>update!<CR>", { desc = "Save File" })

-- Motion
-- map("n", "s", "<cmd>lua require('sj').run()<CR>")
-- map("n", "<A-,>", "<cdm>lua require('sj').prev_match()<CR>")
-- map("n", "<A-;>", "<cdm>lua require('sj').next_match()<CR>")
-- map("n", "<localleader>s", "<cmd>lua require('sj').redo()<CR>")
