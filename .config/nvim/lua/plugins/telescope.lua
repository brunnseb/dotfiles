return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    keys = {
      { "<leader>/", "<cmd>Telescope live_grep_args<CR>", desc = "Grep" },
      {
        "<leader>ff",
        function()
          local path = vim.loop.cwd() .. "/.git"
          local ok, err = vim.loop.fs_stat(path)
          if not ok then
            require("telescope.builtin").find_files()
          else
            require("telescope.builtin").git_files()
          end
          -- local git_repo = vim.fn.system("git rev-parse --show-toplevel 2> /dev/null")
          -- if git_repo == nil then
          -- require("telescope.builtin").find_files()
          -- else
          -- require("telescope.builtin").git_files()
          -- end
        end,
        desc = "Find files",
      },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      "kkharji/sqlite.lua",
      { "prochri/telescope-all-recent.nvim", opts = {} },
      "debugloop/telescope-undo.nvim",
      "natecraddock/telescope-zf-native.nvim",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
      {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        config = function() end,
        dependencies = {
          "kkharji/sqlite.lua",
          { "nvim-telescope/telescope-fzy-native.nvim" },
        },
      },
    },
    config = function()
      local lga_actions = require("telescope-live-grep-args.actions")
      local actions = require("telescope.actions")

      local opts = {
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
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-'>"] = lga_actions.quote_prompt(),
              },
            },
          },
          ["zf-native"] = {
            file = { -- options for sorting file-like items
              enable = true, -- override default telescope file sorter
              highlight_results = true, -- highlight matching text in results
              match_filename = true, -- enable zf filename match priority
            },
            generic = { -- options for sorting all other items
              enable = true, -- override default telescope generic item sorter
              highlight_results = true, -- highlight matching text in results
              match_filename = false, -- disable zf filename match priority
            },
          },
          smart_open = {
            cwd_only = true,
            filename_first = true,
          },
        },
      }

      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("live_grep_args")
      telescope.load_extension("smart_open")
      telescope.load_extension("undo")
      telescope.load_extension("zf-native")
      telescope.load_extension("hbac")
    end,
  },
}
