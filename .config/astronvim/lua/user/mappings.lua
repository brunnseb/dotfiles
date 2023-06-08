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
    ["<leader>o"] = false,
    -- Navigate to occurence
    ["gj"] = { "*", desc = "Next occurence" },
    ["gk"] = { "#", desc = "Previous occurence" },
    -- Files
    ["<leader>fs"] = { "<cmd>update!<CR>", desc = "Save File" },
    ["<leader>fw"] = {
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      desc = "Live grep",
    },
    ["<leader>ff"] = {
      "<cmd>lua require('user.config.telescope').project_files()<CR>",
      desc = "Find files",
    },
    -- Git
    ["<leader>gd"] = { "<cmd>DiffviewOpen<CR>", desc = "Diff" },
    ["<leader>gl"] = { "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
    ["<leader>gL"] = { "<cmd>DiffviewFileHistory<CR>", desc = "History" },
    ["<leader>gb"] = { "<cmd>lua require('gitsigns').blame_line()<CR>", desc = "Blame line" },
    ["<leader>gB"] = { "<cmd>lua require('gitsigns').blame_line({full=true})<CR>", desc = "Blame full" },
    -- Terminal
    ["<leader>cf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
    ["<leader>ch"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
    ["<leader>cv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" },
    -- Telescope
    ["<leader>,"] = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 0.25 }}))<CR>",
      desc = "Open buffers",
    },
    ["<leader>."] = {
      "<cmd>lua require('telescope.builtin').find_files( require('telescope.themes').get_ivy({ cwd = vim.fn.expand('%:p:h'), layout_config = { height = 0.25 }, previewer = false }))<CR>",
      desc = "Files in current directory",
    },
    ["<leader>n"] = { "<cmd>NnnPicker<CR>", desc = "Nnn" },
    -- Kill
    ["<leader>kn"] = {
      function() require("notify").dismiss { silent = true, pending = true } end,
      desc = "Delete all Notifications",
    },
    ["<leader>kd"] = { "<cmd>DiffviewClose<CR>", desc = "close diffview" },
    -- Tests
    ["<leader>tt"] = { "<cmd>lua require('neotest').run.run()<CR>", desc = "Run test" },
    ["<leader>tl"] = { "<cmd>lua require('neotest').run.run_last()<CR>", desc = "Run last test" },
    ["<leader>tf"] = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run all tests in file" },
    ["<leader>ts"] = { "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "Toggle test summary" },
    ["<leader>tS"] = { "<cmd>lua require('neotest').run.stop()<CR>", desc = "Stop test execution" },
    ["<leader>to"] = {
      "<cmd>lua require('neotest').output.open({enter = true, auto_close = true})<CR>",
      desc = "Show test output",
    },
    ["<leader>tO"] = { "<cmd>lua require('neotest').output_panel.toggle()<CR>", desc = "Toggle test output panel" },
    ["<leader>t]"] = {
      "<cmd>lua require('neotest').jump.next({status = 'failed'})<CR>",
      desc = "Jump to next failed test",
    },
    ["<leader>th"] = false,
    ["<leader>tn"] = false,
    ["<leader>tp"] = false,
    ["<leader>tu"] = false,
    ["<leader>tv"] = false,
    ["<leader>t["] = {
      "<cmd>lua require('neotest').jump.prev({status = 'failed'})<CR>",
      desc = "Jump to previous failed test",
    },
    -- Typescript
    ["<leader>lo"] = { "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
    ["<leader>lF"] = { "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
    ["<leader>lu"] = { "<cmd>TypescriptRemoveUnused<CR>", desc = "Remove Unused" },
    ["<leader>lc"] = { "<cmd>lua require('logsitter').log()<CR>", desc = "Logsitter" },
    -- Windows
    ["<leader>w"] = false,
    ["<leader>wd"] = { "<C-W>c", desc = "Delete window" },
    ["<leader>wD"] = { "<cmd>tabclose<CR>", desc = "Delete tab" },
    ["<leader>wh"] = { "<C-w>h", desc = "Go to left window" },
    ["<leader>wj"] = { "<C-w>j", desc = "Go to right window" },
    ["<leader>wk"] = { "<C-w>k", desc = "Go to top window" },
    ["<leader>wl"] = { "<C-w>l", desc = "Go to bottom window" },
    ["<leader>wL"] = { "<cmd>tabnext<Cr>", desc = "Go to next tab" },
    ["<leader>wH"] = { "<cmd>tabprev<CR>", desc = "Go to previous tab" },
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
    ["<leader>uI"] = { "<cmd>IndentBlanklineToggle<cr>", desc = "toggle indent blankline" },
    ["<leader>ul"] = { "<cmd>lua require('lsp_lines').toggle()<cr>", desc = "toggle lsp lines" },
    -- Ufo
    ["zk"] = {
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then vim.lsp.buf.hover() end
      end,
    },
    -- Hop
    ["gs/"] = { "<cmd>HopPattern<CR>", desc = "Hop Pattern" },
    ["gsk"] = { "<cmd>HopWordBC<CR>", desc = "Hop Word Up" },
    ["gsj"] = { "<cmd>HopWordAC<CR>", desc = "Hop Word Down" },
    ["gM"] = { "<cmd>lua require('tsht').nodes()<CR>", desc = "Treehopper Nodes" },
    ["gsK"] = { "<cmd>lua require('tsht').move({ side = 'start' })<CR>", desc = "Treehopper Move Start" },
    ["gsJ"] = { "<cmd>lua require('tsht').move({ side = 'end' })<CR>", desc = "Treehopper Move End" },
    -- Neotree
    ["<leader>E"] = { "<cmd>Neotree focus<CR>", desc = "Explorer focus" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  v = {
    ["gs/"] = { "<cmd>HopPattern<CR>", desc = "Hop Pattern" },
    ["gsk"] = { "<cmd>HopWordBC<CR>", desc = "Hop Word Up" },
    ["gsj"] = { "<cmd>HopWordAC<CR>", desc = "Hop Word Down" },
    ["<"] = { "<gv" },
    [">"] = { ">gv" },

    -- Extract
    ["<leader>ce"] = { "<cmd>lua require('react-extract').extract_to_current_file()<CR>", desc = "extract" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
