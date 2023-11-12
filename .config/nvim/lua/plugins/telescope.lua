return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local actions = require("telescope.actions")

      return {
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
    end,
  },
}
