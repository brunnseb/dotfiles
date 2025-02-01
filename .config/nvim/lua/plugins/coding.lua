return {
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
    "Goose97/timber.nvim",
    version = "*",
    event = "VeryLazy",
    keys = {
      {
        "<leader>lr",
        '<cmd>lua require("timber.actions").clear_log_statements({ global = false })<CR>',
        desc = "Remove logs",
      },
      {
        "<leader>lt",
        '<cmd>lua require("timber.actions").toggle_comment_log_statements({ global = false })<CR>',
        desc = "Toggle logs",
      },
    },
    opts = {
      log_templates = {
        default = {
          javascript = [[console.log("%log_marker %log_target", %log_target)]],
          typescript = [[console.log("%log_marker %log_target", %log_target)]],
          jsx = [[console.log("%log_marker %log_target", %log_target)]],
          tsx = [[console.log("%log_marker %log_target", %log_target)]],
          lua = [[print("%log_marker %log_target", vim.inspect(%log_target))]],
          ruby = [[puts("%log_marker %log_target #{%log_target}")]],
          go = [[log.Printf("%log_marker %log_target: %v\n", %log_target)]],
          rust = [[println!("%log_marker %log_target: {:#?}", %log_target);]],
          python = [[print("%log_marker %log_target", %log_target)]],
          c = [[printf("%log_marker %log_target: %s\n", %log_target);]],
          cpp = [[std::cout << "%log_marker %log_target: " << %log_target << std::endl;]],
          java = [[System.out.println("%log_marker %log_target: " + %log_target);]],
          c_sharp = [[Console.WriteLine($"%log_marker %log_target: {%log_target}");]],
          odin = [[fmt.printfln("%log_marker %log_target: %v", %log_target)]],
        },
        plain = {
          javascript = [[console.log("%log_marker %insert_cursor")]],
          typescript = [[console.log("%log_marker %insert_cursor")]],
          jsx = [[console.log("%log_marker %insert_cursor")]],
          tsx = [[console.log("%log_marker %insert_cursor")]],
          lua = [[print("%log_marker %insert_cursor")]],
          ruby = [[puts("%log_marker %insert_cursor")]],
          go = [[log.Printf("%log_marker %insert_cursor")]],
          rust = [[println!("%log_marker %insert_cursor");]],
          python = [[print("%log_marker %insert_cursor")]],
          c = [[printf("%log_marker %insert_cursor \n");]],
          cpp = [[std::cout << "%log_marker %insert_cursor" << std::endl;]],
          java = [[System.out.println("%log_marker %insert_cursor");]],
          c_sharp = [[Console.WriteLine("%log_marker %insert_cursor");]],
          odin = [[fmt.println("%log_marker %insert_cursor")]],
        },
      },
      batch_log_templates = {
        default = {
          javascript = [[console.log("%log_marker", { %repeat<"%log_target": %log_target><, > })]],
          typescript = [[console.log("%log_marker", { %repeat<"%log_target": %log_target><, > })]],
          jsx = [[console.log("%log_marker", { %repeat<"%log_target": %log_target><, > })]],
          tsx = [[console.log("%log_marker", { %repeat<"%log_target": %log_target><, > })]],
          lua = [[print("%log_marker " .. string.format("%repeat<%log_target=%s><, >", %repeat<vim.inspect(%log_target)><, >))]],
        },
      },
      keymaps = {
        -- Set to false to disable the default keymap for specific actions
        -- insert_log_below = false,
        insert_log_below = "<leader>ln",
        insert_log_above = "<leader>le",
        insert_plain_log_below = "<leader>lo",
        insert_plain_log_above = "<leader>l<S-o>",
        insert_batch_log = "<leader>lb",
        add_log_targets_to_batch = "<leader>la",
        insert_log_below_operator = false,
        insert_log_above_operator = false,
        insert_batch_log_operator = false,
        add_log_targets_to_batch_operator = false,
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
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
