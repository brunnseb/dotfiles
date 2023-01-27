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
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 0.25 }}))<CR>",
  { desc = "Buffers" }
)
map(
  "n",
  "<leader>.",
  "<cmd>lua require('telescope.builtin').find_files( require('telescope.themes').get_ivy({ cwd = vim.fn.expand('%:p:h'), layout_config = { height = 0.25 }, previewer = false }))<CR>",
  { desc = "Files in current directory" }
)

-- Files
map("n", "<leader>fc", "<cmd>e $MYVIMRC <CR>", { desc = "Config" })
map("n", "<leader>fs", "<cmd>update!<CR>", { desc = "Save File" })

-- Buffer
map("n", "<leader>bK", "<cmd>%bd|e#|bd#<Cr>", { desc = "Delete all buffers" })

-- Window
map("n", "<leader>wh", "<C-w>h", { desc = "Go to left window" })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to right window" })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to top window" })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to bottom window" })
map("n", "<leader>wH", "<C-w>H", { desc = "Move window to left" })
map("n", "<leader>wJ", "<C-w>J", { desc = "Move window to right" })
map("n", "<leader>wK", "<C-w>K", { desc = "Move window up" })
map("n", "<leader>wL", "<C-w>L", { desc = "Move window down" })
map("n", "<leader>wS", "<cmd>WindowsMaximizeVertically<CR>", { desc = "maximize vertically" })
map("n", "<leader>ws", "<C-w>s", { desc = "split horizontal" })
map("n", "<leader>wV", "<cmd>WindowsMaximizeHorizontally<CR>", { desc = "maximize horizontally" })
map("n", "<leader>wv", "<C-w>v", { desc = "split vertical" })
map("n", "<leader>wo", "<C-w>o", { desc = "maximize current window" })
map("n", "<leader>wO", "<cmd>WindowsMaximize<CR>", { desc = "maximize current window" })
map("n", "<leader>wp", function()
  local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- Misc
map("n", "<leader>ml", "<cmd> lua require('logsitter').log()<CR>", { desc = "Log symbol" })

-- Neotest
map("n", "<leader>tr", "<cmd> lua require('neotest').run.run()<CR>", { desc = "Run tests" })
map("n", "<leader>tf", "<cmd> lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "Run file" })
map("n", "<leader>ts", "<cmd> lua require('neotest').summary.toggle()<CR>", { desc = "Toggle Summary" })
map("n", "<leader>to", "<cmd> lua require('neotest').output_panel.toggle()<CR>", { desc = "Show Output" })

-- Neotree
map("n", "<leader>E", "<cmd>Neotree focus<CR>", { desc = "Focus Neotree" })

-- Telescope
map("n", "<leader>su", "<cmd>Telescope undo<cr>", { desc = "Undo" })
map("n", "<leader>sv", "<cmd>Telescope registers<cr>", { desc = "Registers" })

-- Project
map(
  "n",
  "<leader>pp",
  "<cmd>lua require'telescope'.extensions.repo.list(require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 0.4 }, file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%qmk_firmware/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh', '/Library/', '/%.cocoapods/'}}))<CR>",
  { desc = "List Repos" }
)
map("n", "<leader>ps", "wa", { desc = "Save all" })

-- Zen
map("n", "<leader>uz", "<cmd>ZenMode<cr>", { desc = "Zen" })

-- Motion
-- map("n", "s", "<cmd>lua require('sj').run()<CR>")
-- map("n", "<A-,>", "<cdm>lua require('sj').prev_match()<CR>")
-- map("n", "<A-;>", "<cdm>lua require('sj').next_match()<CR>")
-- map("n", "<localleader>s", "<cmd>lua require('sj').redo()<CR>")
