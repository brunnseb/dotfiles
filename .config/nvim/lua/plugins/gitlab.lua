return {
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    keys = {
      {
        "<leader>grS",
        function()
          require("gitlab.server").restart(function()
            vim.cmd.tabclose()
            require("gitlab").review() -- Reopen the reviewer after the server restarts
          end)
        end,
        desc = "Restart",
      },
      {
        "<leader>grr",
        function()
          require("gitlab").review()
        end,
        desc = "Review",
      },
      {
        "<leader>grs",
        function()
          require("gitlab").summary()
        end,
        desc = "Summary",
      },
      {
        "<leader>grn",
        function()
          require("gitlab").create_note()
        end,
        desc = "Note",
      },
      {
        "<leader>grc",
        function()
          require("gitlab").create_comment()
        end,
        desc = "Comment",
      },
      {
        "<leader>grc",
        function()
          require("gitlab").create_multiline_comment()
        end,
        desc = "Multiline Comment",
        mode = "v",
      },
      {
        "<leader>grs",
        function()
          require("gitlab").create_comment_suggestion()
        end,
        desc = "Suggestion",
        mode = "v",
      },
      {
        "<leader>grv",
        function()
          require("gitlab").move_to_discussion_tree_from_diagnostic()
        end,
        desc = "View this comment",
      },
      {
        "<leader>grD",
        function()
          require("gitlab").toggle_discussions()
        end,
        desc = "Discussions",
      },
      {
        "<leader>graa",
        function()
          require("gitlab").add_assignee()
        end,
        desc = "Add assignee",
      },
      {
        "<leader>grar",
        function()
          require("gitlab").add_reviewer()
        end,
        desc = "Add reviewer",
      },
      {
        "<leader>grdc",
        function()
          require("gitlab").delete_comment()
        end,
        desc = "Delete comment",
      },
      {
        "<leader>grda",
        function()
          require("gitlab").delete_assignee()
        end,
        desc = "Delete assignee",
      },
      {
        "<leader>grdr",
        function()
          require("gitlab").delete_reviewer()
        end,
        desc = "Delete reviewer",
      },
      {
        "<leader>grA",
        function()
          require("gitlab").approve()
        end,
        desc = "Approve",
      },
      {
        "<leader>grR",
        function()
          require("gitlab").revoke()
        end,
        desc = "Revoke",
      },
    },
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      require("gitlab").setup({
        popup = {
          perform_action = "<C-s>",
        },
        input = {
          enabled = true,
        },
      })
    end,
  },
}
