return {
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")

      return {
        hls = { normal = "Normal", preview_normal = "Normal", border = "Function", preview_border = "Function" },
        winopts = {
          height = 0.45,
          width = 0.6,
          row = 0.5,
          preview = { hidden = "hidden" },
          border = "rounded",
          treesitter = { enabled = true },
        },
        fzf_opts = {
          -- ["--no-info"] = "",
          -- ["--info"] = "hidden",
          ["--padding"] = "10%,5%,10%,5%",
          ["--header"] = " ",
          ["--no-scrollbar"] = "",
        },
        files = {
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
        -- files = {
        --   formatter = "path.filename_first",
        --   git_icons = true,
        --   prompt = "files:",
        --   no_header = true,
        --   cwd_header = false,
        --   cwd_prompt = false,
        --   actions = {
        --     ["ctrl-d"] = {
        --       fn = function(...)
        --         require("fzf-lua").actions.file_vsplit(...)
        --         vim.cmd("windo diffthis")
        --         local switch = vim.api.nvim_replace_termcodes("<C-w>h", true, false, true)
        --         vim.api.nvim_feedkeys(switch, "t", false)
        --       end,
        --       desc = "diff-file",
        --     },
        --   },
        -- },
        -- buffers = {
        --   formatter = "path.filename_first",
        --   prompt = "buffers:",
        --   no_header = true,
        --   fzf_opts = { ["--delimiter"] = " ", ["--with-nth"] = "-1.." },
        -- },
        -- helptags = {
        --   prompt = "💡:",
        --   winopts = {
        --     title = " 💡 ",
        --     title_pos = "center",
        --     width = 0.8,
        --     height = 0.6,
        --     preview = {
        --       hidden = "nohidden",
        --       layout = "horizontal",
        --       horizontal = "down:40%",
        --     },
        --   },
        -- },
        -- git = {
        --   branches = {
        --     prompt = "branches:",
        --     cmd = "git branch -a --format='%(refname:short)'",
        --     no_header = true,
        --     winopts = {
        --       title = "  ",
        --       title_pos = "center",
        --       preview = {
        --         hidden = "hidden",
        --         layout = "vertical",
        --         vertical = "right:50%",
        --         wrap = "wrap",
        --       },
        --       row = 1,
        --       width = vim.api.nvim_win_get_width(0) / 2,
        --       height = 0.3,
        --     },
        --     actions = {
        --       ["default"] = {
        --         fn = function(selected)
        --           vim.cmd.DiffviewOpen({ args = { selected[1] } })
        --         end,
        --         desc = "diffview-git-branch",
        --       },
        --     },
        --   },
        -- },
        -- autocmds = {
        --   prompt = "autocommands:",
        --   winopts = {
        --     width = 0.8,
        --     height = 0.6,
        --     preview = {
        --       hidden = "nohidden",
        --       layout = "horizontal",
        --       horizontal = "down:40%",
        --       wrap = "wrap",
        --     },
        --   },
        -- },
        -- keymaps = {
        --   prompt = "keymaps:",
        --   winopts = {
        --     width = 0.8,
        --     height = 0.6,
        --     preview = {
        --       hidden = "nohidden",
        --       layout = "horizontal",
        --       horizontal = "down:40%",
        --     },
        --   },
        --   actions = {
        --     ["default"] = function(selected)
        --       local lines = vim.split(selected[1], "│", {})
        --       local mode, key = lines[1]:gsub("%s+", ""), lines[2]:gsub("%s+", "")
        --       vim.cmd("verbose " .. mode .. "map " .. key)
        --     end,
        --   },
        -- },
        -- highlights = {
        --   prompt = "highlights:",
        --   winopts = {
        --     width = 0.8,
        --     height = 0.6,
        --     preview = {
        --       hidden = "nohidden",
        --       layout = "horizontal",
        --       horizontal = "down:40%",
        --       wrap = "wrap",
        --     },
        --   },
        -- },
        -- lsp = {
        --   code_actions = {
        --     prompt = "code actions:",
        --     winopts = {
        --       width = 0.8,
        --       height = 0.6,
        --       preview = {
        --         hidden = "nohidden",
        --         layout = "horizontal",
        --         horizontal = "down:75%",
        --       },
        --     },
        --   },
        -- },
        -- registers = {
        --   prompt = "registers:",
        --   winopts = {
        --     width = 0.8,
        --   },
        -- },
        defaults = {
          formatter = "path.filename_first",
          -- formatter = "path.dirname_first",
        },
      }
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
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>uC", false },
    },
  },
}
