return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = { "nvim-mini/mini.sessions" },
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
      padding = true,
      style = "fancy",
      top_down = false,
      max_lines = 5,
    },
    explorer = {
      replace_netrw = true,
      trash = true,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = false,
          auto_close = true,
          layout = {
            position = "right",
          },
          win = {
            list = {
              keys = {
                ["<BS>"] = "explorer_up",
                ["l"] = "confirm",
                ["h"] = "explorer_close", -- close directory
                ["a"] = "explorer_add",
                ["d"] = "explorer_del",
                ["r"] = "explorer_rename",
                ["c"] = "explorer_copy",
                ["m"] = "explorer_move",
                ["o"] = "explorer_open", -- open with system application
                ["P"] = "toggle_preview",
                ["y"] = { "explorer_yank", mode = { "n", "x" } },
                ["p"] = "explorer_paste",
                ["u"] = "explorer_update",
                ["~"] = "tcd",
                ["<leader>/"] = "picker_grep",
                ["<c-t>"] = "terminal",
                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",
              },
            },
          },
        },
      },
      enabled = true,
      ui_select = true,
      layouts = {
        select = {
          layout = {
            box = "horizontal",
            backdrop = false,
            width = 0.8,
            height = 0.4,
            border = "none",
            {
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = true,
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", title = " Results ", title_pos = "center", border = true },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.5,
              border = true,
              title_pos = "center",
            },
          },
        },
        default = {
          layout = {
            box = "horizontal",
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = true,
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", title = " Results ", title_pos = "center", border = true },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.5,
              border = true,
              title_pos = "center",
            },
          },
        },
      },
      layout = {
        preset = "default",
      },
      -- Fuzzy matching settings
      matcher = {
        fuzzy = true,
        smartcase = true,
        filename_bonus = true,
      },
    },
    input = {
      enabled = true,
      icon = " ",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = { style = "input" },
      expand = true,
    },
    -- terminal = {
    --     win = {
    --         style = "terminal",
    --     },
    -- },
    -- STYLES
    styles = {
      notification = {
        border = "bold",
        zindex = 100,
        ft = "markdown",
        wo = {
          wrap = true,
          winblend = 0,
          conceallevel = 2,
        },
        bo = { filetype = "snacks_notif" },
      },

      notification_history = {
        border = "rounded", -- Remove borders completely
        zindex = 100,
        width = 0.6,
        height = 0.6,
        minimal = false,
        title = " Notification History ",
        title_pos = "center",
        ft = "markdown",
        bo = { filetype = "snacks_notif_history", modifiable = false },
        wo = {
          winhighlight = "Normal:SnacksNotifierHistory",
          winblend = 0, -- Remove transparency
        },
        keys = { q = "close" },
      },
      input = {
        backdrop = false,
        position = "float",
        border = "rounded", -- No borders as requested
        title_pos = "center",
        height = 1,
        width = 60,
        relative = "editor",
        noautocmd = false,
        row = 2,
        wo = {
          winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
          cursorline = false,
        },
        bo = {
          filetype = "snacks_input",
          buftype = "prompt",
        },
        b = {
          completion = false, -- disable blink completions in input
        },
        keys = {
          n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
          i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
          i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
          i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
          i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
          i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
          i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
          q = "cancel",
        },
      },
    },
  },
  keys = {
    {
      "<C-p>",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>pf",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>ps",
      function()
        Snacks.picker.grep()
      end,

      desc = "Find word or string in project",
    },
    {
      "<leader>pb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>gB",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },

    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git Branches",
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Hide All Notifications",
    },
    {
      "<leader>mn",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Show Notification History",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
  },
}
