return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {

      provider = "qwen_coder",
      auto_suggestions_provider = "qwen_coder",
      behaviour = {
        auto_suggestions = true,
        auto_suggestions_respect_ignore = false,
        -- auto_set_highlight_group = true,
        -- auto_set_keymaps = true,
        -- auto_apply_diff_after_generation = false,
        -- jump_result_buffer_on_finish = false,
        -- support_paste_from_clipboard = false,
        -- minimize_diff = true,
      },
      vendors = {
        qwen_coder = {
          __inherited_from = "openai",
          api_key_name = "TABBY_API_KEY",
          endpoint = "http://media:5010/v1",
          model = "lucyknada_Qwen_Qwen2.5-Coder-14B-Instruct-exl2",
          temperature = 0.2,
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  { "lambdalisue/vim-suda", cmd = { "SudaWrite", "SudaRead" } },
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {}, -- required even with default settings, since it calls `setup()`
  },
  { "mrjones2014/smart-splits.nvim" },
  {
    "nekowasabi/aider.vim",
    dependencies = "vim-denops/denops.vim",
    event = "VeryLazy",
    config = function()
      vim.g.aider_command = "aider --no-auto-commits --model openai/cgus_DeepSeek-R1-Distill-Qwen-14B-exl2"
      vim.g.aider_buffer_open_type = "floating"
      vim.g.aider_floatwin_width = 100
      vim.g.aider_floatwin_height = 20

      vim.api.nvim_create_autocmd("User", {
        pattern = "AiderOpen",
        callback = function(args)
          vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = args.buf })
          vim.keymap.set("n", "<Esc>", "<cmd>AiderHide<CR>", { buffer = args.buf })
        end,
      })
      -- vim.api.nvim_set_keymap('n', '<leader>at', ':AiderRun<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>aa', ':AiderAddCurrentFile<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>ar', ':AiderAddCurrentFileReadOnly<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>aw', ':AiderAddWeb<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>ax', ':AiderExit<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>ai', ':AiderAddIgnoreCurrentFile<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>aI', ':AiderOpenIgnore<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>aI', ':AiderPaste<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>ah', ':AiderHide<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('v', '<leader>av', ':AiderVisualTextWithPrompt<CR>', { noremap = true, silent = true })
    end,
  },
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
