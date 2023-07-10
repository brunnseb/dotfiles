local M = {}

M.setup = function()
  local gitsigns = require "gitsigns"
  local Hydra = require "hydra"
  -- local utils = require "astronvim.utils"

  local hint = [[
 _J_: next hunk   _s_: stage hunk                  
 _K_: prev hunk   _d_: show deleted      
 ^ ^              _u_: undo last stage   
 ^ ^              _p_: preview hunk      
 ^ ^              _r_: reset hunk      
 ^
 ^ ^              _q_: exit
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
        -- vim.bo.modifiable = false
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
        gitsigns.toggle_deleted(true)
      end,
      on_exit = function()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd "loadview"
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.cmd "normal zv"
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
      end,
    },
    mode = { "n", "x" },
    body = "<leader>gh",
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
      { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
      { "r", gitsigns.reset_hunk, { desc = "reset hunk" } },
      { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
      { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    },
  }
end

return M
