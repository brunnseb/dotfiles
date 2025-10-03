-- Configuration for opencode.nvim plugin
-- This file sets up the opencode.nvim plugin with its dependencies and keymaps
return {
  {
    "sudo-tee/opencode.nvim",
    opts = {
      default_global_keymaps = false, -- If false, disables all default global keymaps
      keymap = {
        global = {
          toggle = "<leader>ag", -- Open opencode. Close if opened
          open_input = "<leader>aN", -- Opens and focuses on input window on insert mode
          open_input_new_session = "<leader>aI", -- Opens and focuses on input window on insert mode. Creates a new session
          open_output = "<leader>ao", -- Opens and focuses on output window
          toggle_focus = "<leader>at", -- Toggle focus between opencode and last window
          close = "<leader>aq", -- Close UI windows
          select_session = "<leader>as", -- Select and load a opencode session
          configure_provider = "<leader>ap", -- Quick provider and model switch from predefined list
          diff_open = "<leader>ad", -- Opens a diff tab of a modified file since the last opencode prompt
          diff_next = "<leader>a]", -- Navigate to next file diff
          diff_prev = "<leader>a[", -- Navigate to previous file diff
          diff_close = "<leader>aq", -- Close diff view tab and return to normal editing
          diff_revert_all_last_prompt = "<leader>ara", -- Revert all file changes since the last opencode prompt
          diff_revert_this_last_prompt = "<leader>art", -- Revert current file changes since the last opencode prompt
          diff_revert_all = "<leader>arA", -- Revert all file changes since the last opencode session
          diff_revert_this = "<leader>arT", -- Revert current file changes since the last opencode session
          swap_position = "<leader>ax", -- Swap Opencode pane left/right
        },
        window = {
          submit = "<C-S>", -- Submit prompt (normal mode)
          submit_insert = "<C-S>", -- Submit prompt (insert mode)
          close = "q", -- Close UI windows
          stop = "<C-c>", -- Stop opencode while it is running
          next_message = "]]", -- Navigate to next message in the conversation
          prev_message = "[[", -- Navigate to previous message in the conversation
          mention = "@", -- Insert mention (file/agent)
          mention_file = "~", -- Pick a file and add to context. See File Mentions section
          slash_commands = "/", -- Pick a command to run in the input window
          toggle_pane = "<tab>", -- Toggle between input and output panes
          prev_prompt_history = "<up>", -- Navigate to previous prompt in history
          next_prompt_history = "<down>", -- Navigate to next prompt in history
          switch_mode = "<M-m>", -- Switch between modes (build/plan)
          focus_input = "<C-i>", -- Focus on input window and enter insert mode at the end of the input from the output window
          select_child_session = "<leader>aS", -- Select and load a child session
          debug_message = "<leader>oD", -- Open raw message in new buffer for debugging
          debug_output = "<leader>oO", -- Open raw output in new buffer for debugging
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
      },
      -- Optional, for file mentions and commands completion, pick only one
      "saghen/blink.cmp",
      -- 'hrsh7th/nvim-cmp',

      -- Optional, for file mentions picker, pick only one
      "folke/snacks.nvim",
      -- 'nvim-telescope/telescope.nvim',
      -- 'ibhagwan/fzf-lua',
      -- 'nvim_mini/mini.nvim',
    },
  },
  -- {
  --   "NickvanDyke/opencode.nvim",
  --   dependencies = {
  --     -- Recommended for better prompt input, and required to use `opencode.nvim`'s embedded terminal — otherwise optional
  --     { "folke/snacks.nvim", opts = { input = { enabled = true } } },
  --   },
  --   config = function()
  --     -- Set global options for opencode.nvim
  --     vim.g.opencode_opts = {
  --       -- Your configuration, if any — see `lua/opencode/config.lua`
  --     }
  --
  --     -- Required for `opts.auto_reload`
  --     vim.opt.autoread = true
  --
  --     -- Recommended/example keymaps
  --     -- stylua: ignore
  --     vim.keymap.set("n", "<leader>at", function() require("opencode").toggle() end, { desc = "Toggle embedded" })
  --     -- stylua: ignore
  --     vim.keymap.set("n", "<leader>aA", function() require("opencode").ask() end, { desc = "Ask" })
  --     -- stylua: ignore
  --     vim.keymap.set("n", "<leader>aa", function() require("opencode").ask("@cursor: ") end, { desc = "Ask about this" })
  --     -- stylua: ignore
  --     vim.keymap.set("v", "<leader>aa", function() require("opencode").ask("@selection: ") end, { desc = "Ask about selection" })
  --     -- stylua: ignore
  --     vim.keymap.set("n", "<leader>ae", function() require("opencode").prompt("Explain @cursor and its context") end, { desc = "Explain this code" })
  --     -- stylua: ignore
  --     vim.keymap.set("n", "<leader>a+", function() require("opencode").prompt("@buffer", { append = true }) end, { desc = "Add buffer to prompt" })
  --     -- stylua: ignore
  --     vim.keymap.set("v", "<leader>a+", function() require("opencode").prompt("@selection", { append = true }) end, { desc = "Add selection to prompt" })
  --     -- stylua: ignore
  --     vim.keymap.set("n", "<leader>an", function() require("opencode").command("session_new") end, { desc = "New session" })
  --     -- stylua: ignore
  --     vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, { desc = "Messages half page up" })
  --     -- stylua: ignore
  --     vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, { desc = "Messages half page down" })
  --     -- stylua: ignore
  --     vim.keymap.set({ "n", "v" }, "<leader>os", function() require("opencode").select() end, { desc = "Select prompt" })
  --   end,
  -- },
}
