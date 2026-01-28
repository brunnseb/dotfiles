return {
  {
    "folke/sidekick.nvim",
    keys = {},
    opts = {
      nes = {
        enabled = false,
      },
      copilot = {
        status = {
          enabled = false,
        },
      },
      cli = {
        mux = {
          backend = "tmux",
          enabled = false,
          create = "split",
        },
        tools = {
          pi = {
            cmd = { "pi" },
            -- Optional: custom keymaps for this tool
            -- keys = {
            --   submit = {
            --     "<c-s>",
            --     function(t)
            --       t:send("\n")
            --     end,
            --   },
            -- },
          },
        },
      },
    },
  },
}
