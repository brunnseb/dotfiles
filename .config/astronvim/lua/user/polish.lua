-- autocmds
-- vim.api.nvim_create_autocmd("winleave", {
--   desc = "prevent opening files from telescope in insert mode",
--   -- group = vim.api.nvim_create_augroup("autocomp", { clear = true }),
--   pattern = "*",
--   callback = function()
--     if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
--       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
--     end
--   end,
-- })
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "qf", "lspinfo", "neotest-output", "neotest-output-panel", "spectre_panel" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})

local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true })
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { group = hocon_group, pattern = "*/*.conf", command = "set ft=hocon" }
)

-- Keymaps
vim.cmd "map L $"
vim.cmd "map H ^"

-- Hydras
local gitsigns = require "gitsigns"
local Hydra = require "hydra"
local utils = require "astronvim.utils"

local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted          _b_: blame line
 _K_: prev hunk   _S_: stage buffer      _D_: diff                  _B_: blame show full
 ^ ^              _u_: undo last stage   _h_: file history          _/_: show base file
 ^ ^              _p_: preview hunk      _H_: history current file  ^ ^
 ^
 ^ ^              _g_: Lazygit           _q_: exit
]]

Hydra {
  name = "Git",
  hint = hint,
  config = {
    buffer = bufnr,
    color = "pink",
    invoke_on_body = true,
    hint = {
      border = "rounded",
    },
    on_enter = function()
      vim.cmd "mkview"
      vim.cmd "silent! %foldopen!"
      vim.bo.modifiable = false
      gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
    end,
    on_exit = function()
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd "loadview"
      vim.api.nvim_win_set_cursor(0, cursor_pos)
      vim.cmd "normal zv"
      gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_deleted(false)
    end,
  },
  mode = { "n", "x" },
  body = "<leader>g",
  heads = {
    {
      "J",
      function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gitsigns.next_hunk() end)
        return "<Ignore>"
      end,
      { expr = true, desc = "next hunk" },
    },
    {
      "K",
      function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return "<Ignore>"
      end,
      { expr = true, desc = "prev hunk" },
    },
    { "s", "<cmd>Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
    { "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
    { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
    { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
    { "D", "<cmd>DiffviewOpen<CR>", { exit = true, desc = "diff" } },
    { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
    { "b", gitsigns.blame_line, { desc = "blame" } },
    { "h", "<cmd>DiffviewFileHistory<CR>", { desc = "history", exit = true } },
    { "H", "<cmd>DiffviewFileHistory %<CR>", { desc = "history current file", exit = true } },
    { "B", function() gitsigns.blame_line { full = true } end, { desc = "blame show full" } },
    { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
    {
      "g",
      function() utils.toggle_term_cmd "lazygit" end,
      { desc = "Lazygit" },
    },
    { "q", nil, { exit = true, nowait = true, desc = "exit" } },
  },
}
