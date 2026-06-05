return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        win = {
          keys = {
            prompt = { "<a-l>", "prompt", mode = "t" }, -- Alt+L opens prompt in terminal mode
          },
        },
        mux = {
          backend = "tmux",
          enabled = true, -- Use tmux for session persistence across windows
        },
        tools = {
          pi = {
            cmd = { "pi" }, -- Register pi as a sidekick tool
          },
          omp = {
            cmd = { "omp" },
          },
        },
      },
    },
    keys = {
      -- Focus the sidekick panel from any mode
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        desc = "Sidekick Focus",
        mode = { "n", "t", "i", "x" },
      },
      -- Toggle the sidekick panel open/closed
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      -- Select which AI tool/agent to use
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        desc = "Select CLI",
      },
      -- Close/detach the current CLI session
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      -- Send selected text or current line to the AI
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      -- Send the entire file to the AI
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      -- Send visual selection to the AI
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      -- Open a prompt for user input in the sidekick panel
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
    },
  },
}
