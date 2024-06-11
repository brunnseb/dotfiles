return {
  -- better diagnostics list and others
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = {
      use_diagnostic_signs = true,
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
      { '<leader>xx', '<cmd>Trouble diagnostics_buffer<cr>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics_project<cr>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble quickfix<cr>', desc = 'Quickfix List (Trouble)' },
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
