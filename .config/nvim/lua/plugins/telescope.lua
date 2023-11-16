return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    keys = {
      { "<leader>ff", false },
      { "<leader>/", false },
    },
    config = function()
      local lga_actions = require("telescope-live-grep-args.actions")
      local actions = require("telescope.actions")

      local opts = {
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-'>"] = lga_actions.quote_prompt(),
              },
            },
          },
        },
        defaults = {
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-h>"] = actions.to_fuzzy_refine,
              ["<C-u>"] = false,
              ["<esc>"] = actions.close,
              ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      }
      require("telescope").setup(opts)

      require("telescope").load_extension("live_grep_args")
    end,
  },
}
