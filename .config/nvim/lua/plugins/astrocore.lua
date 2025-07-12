-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      -- large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      -- autopairs = true, -- enable autopairs at start
      -- cmp = true, -- enable completion at start
      -- diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      -- highlighturl = true, -- highlight URLs at start
      -- notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      -- virtual_text = true,
      -- underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- -- see `:h vim.filetype.add` for usage
      -- extension = {
      --   foo = "fooscript",
      -- },
      -- filename = {
      --   [".foorc"] = "fooscript",
      -- },
      -- pattern = {
      --   [".*/etc/foo/.*"] = "fooscript",
      -- },
    },
    -- vim options can be configured here
    options = {
      -- opt = { -- vim.opt.<key>
      --   relativenumber = true, -- sets vim.opt.relativenumber
      --   number = true, -- sets vim.opt.number
      --   spell = false, -- sets vim.opt.spell
      --   signcolumn = "yes", -- sets vim.opt.signcolumn to yes
      --   wrap = false, -- sets vim.opt.wrap
      -- },
      -- g = { -- vim.g.<key>
      --   -- configure global vim variables (vim.g)
      --   -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
      --   -- This can be found in the `lua/lazy_setup.lua` file
      -- },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        ["\\"] = false,
        ["<C-S>"] = "<CMD>w<CR>",
        ["<leader>y"] = { desc = "🗄Yazi" },
        ["<C-Left>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
        ["<C-Down>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
        ["<C-Up>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
        ["<C-Right>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
        ["<A-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
        ["<A-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
        ["<A-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
        ["<A-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
      },
      i = {
        ["<C-S>"] = "<CMD>w<CR>",
        ["<C-Left>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
        ["<C-Down>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
        ["<C-Up>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
        ["<C-Right>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
        ["<A-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
        ["<A-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
        ["<A-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
        ["<A-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
      },
    },
  },
}
