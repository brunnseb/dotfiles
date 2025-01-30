return {
  {
    dir = vim.fn.expand("$HOME/Development/bropilot.nvim/"),
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "j-hui/fidget.nvim",
    },
    opts = {
      auto_suggest = false,
      model_params = {
        top_p = 0.8,
        top_k = 20,
        repetition_penalty = 1.05,
        temperature = 0.2,
        num_ctx = 32768,
        -- max_tokens = 100,
        speculative_ngram = true,
        stop = { "<|fim_pad|>", "<|endoftext|>" },
      },
      -- model_params = {
      --   mirostat = 0,
      --   mirostat_eta = 0.1,
      --   mirostat_tau = 5.0,
      --   repeat_last_n = 64,
      --   repeat_penalty = 1.1,
      --   temperature = 0.8,
      --   seed = 0,
      --   stop = {},
      --   tfs_z = 1,
      --   num_predict = 128,
      --   top_k = 40,
      --   top_p = 0.9,
      --   min_p = 0.0,
      -- },
      prompt = {
        prefix = "<|fim_prefix|>",
        suffix = "<|fim_suffix|>",
        middle = "<|fim_middle|>",
      },
      -- debounce = 500, -- careful with this setting when auto_suggest is enabled, can lead to curl jobs overload
      keymap = {
        accept_word = "<C-Right>",
        accept_line = "<S-Right>",
        accept_block = "<C-Up>",
        suggest = "<C-Down>",
      },
      ollama_url = "http://media:5010/v1",
    },
    config = function(_, opts)
      require("bropilot").setup(opts)
    end,
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  { "lambdalisue/vim-suda", cmd = { "SudaWrite", "SudaRead" } },
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {}, -- required even with default settings, since it calls `setup()`
  },
  { "mrjones2014/smart-splits.nvim" },
  {
    "Goose97/timber.nvim",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
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
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    opts = {}, -- required, even if empty
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    priority = 1000,
    event = "VeryLazy", -- Or `LspAttach`
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "powerline",
      })
    end,
  },
}
