return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>,", false },
      { "<leader>/", false },
      { "<leader><space>", "<leader>fF", remap = true, desc = "Find Files (cwd)" },
    },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      {
        "debugloop/telescope-undo.nvim",
      },
      {
        "cljoly/telescope-repo.nvim",
      },
    },
    config = function()
      local actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")

      local git_icons = {
        added = "+",
        changed = "~",
        copied = ">",
        deleted = "x",
        renamed = "➡",
        unmerged = "‡",
        untracked = "?",
      }

      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column=120",
            "--smart-case",
          },
          layout_config = {
            horizontal = {
              preview_cutoff = 120,
            },
            prompt_position = "top",
          },
          entry_prefix = "  ",
          prompt_prefix = "  ",
          selection_caret = "  ",
          file_sorter = require("telescope.sorters").get_fzy_sorter,
          color_devicons = true,

          git_icons = git_icons,

          sorting_strategy = "ascending",

          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

          mappings = {
            i = {
              ["<C-x>"] = false,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
              ["<C-h>"] = "which_key",
              ["<ESC>"] = actions.close,
            },
            n = {
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
            },
          },
        },
        extensions = {
          fzf = {
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
              i = {
                ["<C-i>"] = lga_actions.quote_prompt(),
                ["<C-o>"] = lga_actions.quote_prompt({
                  postfix = " --hidden .config/",
                }),
              },
            },
          },
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("repo")
      require("telescope").load_extension("undo")
      require("telescope").load_extension("live_grep_args")
    end,
  },
}
