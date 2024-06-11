return {
  -- better diagnostics list and others
  {
    'folke/trouble.nvim',
    opts = {
      auto_preview = false,
      modes = {
        diagnostics_buffer = {
          mode = 'diagnostics', -- inherit from diagnostics mode
          filter = { buf = 0 }, -- filter diagnostics to the current buffer
        },
        diagnostics_project = {
          mode = 'diagnostics', -- inherit from diagnostics mode
          filter = {
            any = {
              buf = 0, -- current buffer
              {
                severity = vim.diagnostic.severity.ERROR, -- errors only
                -- limit to files in the current project
                function(item)
                  return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                end,
              },
            },
          },
        },
      },
    },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics_buffer toggle focus=true<cr>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics_project toggle focus=true<cr>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble quickfix toggle focus=true<cr>', desc = 'Quickfix List (Trouble)' },
      { '<leader>xf', '<cmd>Trouble fzf_files toggle focus=true<cr>', desc = 'Fzf List (Trouble)' },
    },
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble' },
    event = 'VimEnter',
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
}
