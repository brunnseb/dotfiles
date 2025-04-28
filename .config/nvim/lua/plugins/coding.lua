return {
  {
    "ThePrimeagen/refactoring.nvim",
    opts = {
      print_var_statements = {
        typescript = {
          'console.log("%s", %s);',
        },
        typescriptreact = {
          'console.log("%s", %s);',
        },
        javascript = {
          'console.log("%s", %s);',
        },
      },
    },
  },
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {
      mapping = {
        startStopRecording = "<C-q>",
        switchSlot = "<M-q>",
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
    init = function()
      -- Vim Multi Cursor Highlights
      vim.g.VM_Mono_hl = "MultiCursorMono"
      vim.g.VM_Extend_hl = "MultiCursorExtend"
      vim.g.VM_Cursor_hl = "MultiCursorCursor"
      vim.g.VM_Insert_hl = "MultiCursorInsert"

      vim.g.VM_leader = ","
      vim.g.VM_maps = {
        ["Add Cursor Down"] = ",<Down>",
        ["Add Cursor Up"] = ",<Up>",
        ["Add Cursor At Pos"] = ",,",
        ["Motion ,"] = ",;",
        ["Undo"] = "u",
        ["Redo"] = "<C-r>",
        ["I Return"] = "<S-CR>",
        ["I Down Arrow"] = "",
        ["I Up Arrow"] = "",
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "BufEnter",
    opts = {
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "gsr",
        normal_cur = "gsa",
        normal_line = "gsR",
        normal_cur_line = "gsA",
        visual = ";",
        visual_line = "gS",
        delete = "gsd",
        change = "gsc",
        change_line = "gsC",
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      completion = {
        accept = { auto_brackets = { enabled = false } },
      },
      -- signature = { enabled = false },
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion", "path" },
        },
        providers = {
          path = {
            opts = {
              trailing_slash = false,
              label_trailing_slash = false,
            },
          },
          codecompanion = {
            name = "CodeCompanion",
            module = "codecompanion.providers.completion.blink",
            enabled = true,
          },
          snippets = {
            name = "Snippets",
            module = "blink.cmp.sources.snippets",
            score_offset = 0,
          },
        },
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      {
        "<leader>P",
        function()
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.yank_history.yank_history({})
          else
            vim.cmd([[YankyRingHistory]])
          end
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
  },
}
