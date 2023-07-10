local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system "git rev-parse --is-inside-work-tree"
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

M.setup = function(opts)
  local lga_actions = require "telescope-live-grep-args.actions"
  local actions = require "telescope.actions"

  opts.defaults.mappings.i = {
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-h>"] = actions.to_fuzzy_refine,
    ["<C-u>"] = false,
    ["<esc>"] = actions.close,
    ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
  }

  opts.extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-'>"] = lga_actions.quote_prompt(),
        },
      },
    },
  }

  require("telescope").setup(opts)

  require("telescope").load_extension "live_grep_args"
end

return M
