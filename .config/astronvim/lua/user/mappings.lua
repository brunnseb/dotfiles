-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- Disable
    ["<leader>c"] = false,
    ["<leader>C"] = false,
    -- Navigate to occurence
    ["gj"] = { "*", desc = "Next occurence" },
    ["gk"] = { "#", desc = "Previous occurence" },
    -- Files
    ["<leader>fs"] = { "<cmd>update!<CR>", desc = "Save File" },
    -- Telescope
    ["<leader>,"] = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 0.25 }}))<CR>",
      desc = "Open buffers",
    },
    ["<leader>."] = {
      "<cmd>lua require('telescope.builtin').find_files( require('telescope.themes').get_ivy({ cwd = vim.fn.expand('%:p:h'), layout_config = { height = 0.25 }, previewer = false }))<CR>",
      desc = "Files in current directory",
    },
    -- Kill
    ["<leader>kn"] = {
      function() require("notify").dismiss { silent = true, pending = true } end,
      desc = "Delete all Notifications",
    },
    -- Windows
    ["<leader>w"] = false,
    ["<leader>wd"] = { "<C-W>c", desc = "Delete window" },
    ["<leader>wh"] = { "<C-w>h", desc = "Go to left window" },
    ["<leader>wj"] = { "<C-w>j", desc = "Go to right window" },
    ["<leader>wk"] = { "<C-w>k", desc = "Go to top window" },
    ["<leader>wl"] = { "<C-w>l", desc = "Go to bottom window" },
    ["<leader>wH"] = { "<C-w>H", desc = "Move window to left" },
    ["<leader>wJ"] = { "<C-w>J", desc = "Move window to right" },
    ["<leader>wK"] = { "<C-w>K", desc = "Move window up" },
    ["<leader>wL"] = { "<C-w>L", desc = "Move window down" },
    ["<leader>wS"] = { "<cmd>WindowsMaximizeVertically<CR>", desc = "maximize vertically" },
    ["<leader>ws"] = { "<C-w>s", desc = "split horizontal" },
    ["<leader>wV"] = { "<cmd>WindowsMaximizeHorizontally<CR>", desc = "maximize horizontally" },
    ["<leader>wv"] = { "<C-w>v", desc = "split vertical" },
    ["<leader>wo"] = { "<C-w>o", desc = "maximize current window" },
    ["<leader>wO"] = { "<cmd>WindowsMaximize<CR>", desc = "maximize current window" },
    ["<leader>wp"] = {
      function()
        local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end,
      desc = "Pick a window",
    },
    -- Buffers
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>bd"] = { "<cmd>bd<CR>", desc = "Delete Buffer" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- UI toggles
    ["<leader>uz"] = { "<cmd>ZenMode<cr>", desc = "toggle Zen mode" },
    -- Ufo
    ["zk"] = {
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then vim.lsp.buf.hover() end
      end,
    },
    -- Hop
    ["gs/"] = { "<cmd>HopPattern<CR>", desc = "Hop Pattern" },
    ["gsk"] = { "<cmd>HopLineBC<CR>", desc = "Hop Line Up" },
    ["gsj"] = { "<cmd>HopLineAC<CR>", desc = "Hop Line Down" },
    -- Neotree
    ["<leader>E"] = { "<cmd>Neotree focus<CR>", desc = "Explorer focus" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  v = {
    ["gs/"] = { "<cmd>HopPattern<CR>", desc = "Hop Pattern" },
    ["gsk"] = { "<cmd>HopLineBC<CR>", desc = "Hop Line Up" },
    ["gsj"] = { "<cmd>HopLineAC<CR>", desc = "Hop Line Down" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
