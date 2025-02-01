return {
  { "lambdalisue/vim-suda", cmd = { "SudaWrite", "SudaRead" } },
  { "mrjones2014/smart-splits.nvim" },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            auto_close = true,
            focus = "input",
          },
          buffers = {
            layout = "ivy",
          },
          undo = {
            layout = "sidebar",
          },
          grep_word = {
            layout = "ivy_split",
          },
        },
      },
    },
  },
  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        left = "<M-Left>",
        right = "<M-Right>",
        down = "<M-Down>",
        up = "<M-Up>",
      },
    },
  },
  {
    "DreamMaoMao/yazi.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    keys = {
      { "<leader>fn", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
    },
  },
  {
    "LintaoAmons/cd-project.nvim",
    keys = {
      { "<leader>pa", "<cmd>CdProjectAdd<CR>", desc = "[A]dd Project" },
      { "<leader>pp", "<cmd>CdProject<CR>", desc = "List [P]rojects" },
      {
        "<leader>pd",
        function()
          local api = require("cd-project.api")
          local bundles = api.get_project_names()
          vim.ui.select(bundles, {
            prompt = "Select project to delete",
          }, function(name)
            ---@diagnostic disable-next-line: missing-fields
            api.delete_project({ name = name })
          end)
        end,
        desc = "[D]elete project",
      },
    },
    config = function()
      require("cd-project").setup({
        projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/cd-project.nvim.json"),
        project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
        choice_format = "both", -- optional, you can switch to "name" or "path"
        hooks = {
          {
            callback = function(dir)
              vim.notify("switched to dir: " .. dir)
            end,
          },
        },
      })
    end,
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = {
        ["_"] = { "treesitter", "lsp" },
        lua = { "lsp" },
      },
      keymaps = {
        ["<Right>"] = "actions.tree_open",
        ["<S-Right>"] = "actions.tree_open_recursive",
        ["<Left>"] = "actions.tree_close",
        ["<S-Left>"] = "actions.tree_close_recursive",
      },
      icons = {
        Struct = " ",
      },
      on_first_symbols = function(bufnr)
        require("aerial").tree_set_collapse_level(bufnr, 2)
      end,
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "marilari88/neotest-vitest" },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("neotest").setup({
        consumers = {
          -- overseer = require 'neotest.consumers.overseer',
        },
        adapters = {
          require("neotest-vitest")({}),
        },
      })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>a", group = "ai", icon = { icon = "󱚥 " } },
          { "<leader>p", group = "project", icon = { icon = " " } },
          { "<leader>l", group = "log", icon = { icon = " ", color = "green" } },
          { "<leader>o", group = "overseer", icon = { icon = "󰜎 ", color = "cyan" } },
        },
      },
    },
  },
  {
    "stevearc/overseer.nvim",
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      overseer.load_template("suisa")

      overseer.add_template_hook({
        dir = {
          vim.fn.expand("$HOME/Development/SUISA/cockpit/"),
          vim.fn.expand("$HOME/Development/SUISA/cockpit/libs/cockpit-core/"),
          vim.fn.expand("$HOME/Development/SUISA/cockpit/libs/cockpit-widgets"),
          vim.fn.expand("$HOME/Development/SUISA/ipi"),
          vim.fn.expand("$HOME/Development/SUISA/ipi/libs/ipi-core"),
          vim.fn.expand("$HOME/Development/SUISA/ipi/libs/ipi-master-domain"),
        },
        module = "^npm$",
      }, function(task_defn, _)
        task_defn.cmd = "pnpm"
      end)
    end,
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T" },
        },
      },
    },
  },
}
