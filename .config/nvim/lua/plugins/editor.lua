local function is_gp_buffer(buf_nr)
  local content = vim.api.nvim_buf_get_lines(buf_nr, 0, 1, false)
  return string.sub(table.concat(content, "\n"), 0, 8) == "# topic:"
end

return {
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    keys = {
      {
        "<leader>grS",
        function()
          require("gitlab.server").restart(function()
            vim.cmd.tabclose()
            require("gitlab").review() -- Reopen the reviewer after the server restarts
          end)
        end,
        desc = "Restart",
      },
      {
        "<leader>grr",
        function()
          require("gitlab").review()
        end,
        desc = "Review",
      },
      {
        "<leader>grs",
        function()
          require("gitlab").summary()
        end,
        desc = "Summary",
      },
      {
        "<leader>grn",
        function()
          require("gitlab").create_note()
        end,
        desc = "Note",
      },
      {
        "<leader>grc",
        function()
          require("gitlab").create_comment()
        end,
        desc = "Comment",
      },
      {
        "<leader>grc",
        function()
          require("gitlab").create_multiline_comment()
        end,
        desc = "Multiline Comment",
        mode = "v",
      },
      {
        "<leader>grs",
        function()
          require("gitlab").create_comment_suggestion()
        end,
        desc = "Suggestion",
        mode = "v",
      },
      {
        "<leader>grv",
        function()
          require("gitlab").move_to_discussion_tree_from_diagnostic()
        end,
        desc = "View this comment",
      },
      {
        "<leader>grD",
        function()
          require("gitlab").toggle_discussions()
        end,
        desc = "Discussions",
      },
      {
        "<leader>graa",
        function()
          require("gitlab").add_assignee()
        end,
        desc = "Add assignee",
      },
      {
        "<leader>grar",
        function()
          require("gitlab").add_reviewer()
        end,
        desc = "Add reviewer",
      },
      {
        "<leader>grdc",
        function()
          require("gitlab").delete_comment()
        end,
        desc = "Delete comment",
      },
      {
        "<leader>grda",
        function()
          require("gitlab").delete_assignee()
        end,
        desc = "Delete assignee",
      },
      {
        "<leader>grdr",
        function()
          require("gitlab").delete_reviewer()
        end,
        desc = "Delete reviewer",
      },
      {
        "<leader>grA",
        function()
          require("gitlab").approve()
        end,
        desc = "Approve",
      },
      {
        "<leader>grR",
        function()
          require("gitlab").revoke()
        end,
        desc = "Revoke",
      },
    },
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      require("gitlab").setup({
        popup = {
          perform_action = "<C-s>",
        },
        input = {
          enabled = true,
        },
      })
    end,
  },
  {
    "luukvbaal/nnn.nvim",
    opts = {},
    keys = {
      { "<leader>fn", "<cmd>NnnPicker %:p:h<CR>", desc = "Nnn Picker" },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      { "S", mode = { "x", "o" }, false },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        custom_filter = function(buf_number)
          return is_gp_buffer(buf_number) ~= true
        end,
      },
    },
  },
  {
    "robitx/gp.nvim",
    cmd = { "GpChatNew", "GpChatToggle" },
    keys = {
      {
        "<leader>ad",
        ":<C-u>'<,'>GpPrepend write docstring<CR>",
        mode = "v",
        desc = "Write docstring using TsDoc",
      },
      {
        "<leader>at",
        ":<C-u>'<,'>GpEnew write tests using vitest and react testing library while importing all needed functions from vitest<CR>",
        mode = "v",
        desc = "Write tests into new file",
      },
      {
        "<leader>ai",
        ":<C-u>'<,'>GpImplement<CR>",
        mode = "v",
        desc = "Implement",
      },
      {
        "<leader>at",
        "<cmd>GpChatToggle<CR>",
        desc = "Toggle Chat",
      },
      {
        "<leader>aq",
        "<cmd>GpChatDelete<CR>",
        desc = "Delete Chat",
      },
      {
        "<leader>an",
        "<cmd>GpChatNew<CR>",
        desc = "New Chat",
      },
    },
    config = function()
      require("gp").setup({
        hooks = {
          -- GpImplement rewrites the provided selection/range based on comments in it
          Implement = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please rewrite this according to the contained instructions."
              .. "\n\nRespond exclusively with the snippet that should replace the selection above."

            local agent = gp.get_command_agent()
            -- gp.Info("Implementing selection with agent: " .. agent.name)

            gp.Prompt(
              params,
              gp.Target.append,
              nil, -- command will run directly without any prompting for user input
              agent.model,
              template,
              agent.system_prompt
            )
          end,
        },
      })

      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)

      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
  },
  {
    "uga-rosa/translate.nvim",
    cmd = { "Translate" },
    opts = {
      default = {
        output = "replace",
        parse_before = "concat,trim,natural",
      },
    },
  },
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      -- opts.left = opts.left or {}
      -- table.insert(opts.left, {
      --   ft = "oil",
      -- })

      -- opts.top = {
      --   { ft = "nnn", size = { height = 0.2 } },
      -- }
      opts.right = {
        { ft = "Fm" },
        {
          ft = "markdown",
          -- pinned = true,
          title = "ChatGPT",
          size = { width = 0.25 },
          filter = function(buf)
            return is_gp_buffer(buf)
          end,
          -- open = "GpChatToggle",
        },
        { ft = "Outline", pinned = true, open = "Outline" },
      }
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {
      patterns = { ".git", ".neoconf.json" },
      detection_methods = { "pattern" },
    },
  },
  {
    "silvercircle/outline.nvim",
    cmd = { "Outline" },
    keys = {
      { "<leader>co", "<cmd>OutlineFocus<CR>", "Outline Focus" },
      { "<leader>cO", "<cmd>Outline<CR>", "Outline" },
    },
    config = true,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        "neotest-vitest",
      },
    },
  },
  { "metakirby5/codi.vim" },
  { "kevinhwang91/nvim-bqf" },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 1) and "▲" or "▼")
          elseif absRelIdx == 1 then
            indicator = sfw ~= (relIdx == 1) and "▲" or "▼"
          else
            indicator = ""
          end

          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            if indicator ~= "" then
              text = ("[%s %d/%d]"):format(indicator, idx, cnt)
            else
              text = ("[%d/%d]"):format(idx, cnt)
            end
            chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
          else
            text = ("[%s %d]"):format(indicator, idx)
            chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end,
        -- calm_down = true,
        -- nearest_only = true,
        -- nearest_float_when = "always",
      })

      -- run `:nohlsearch` and export results to quickfix
      -- if Neovim is 0.8.0 before, remap yourself.
      vim.keymap.set({ "n", "x" }, "<Leader>S", function()
        vim.schedule(function()
          if require("hlslens").exportLastSearchToQuickfix() then
            vim.cmd("cw")
          end
        end)
        return ":noh<CR>"
      end, { expr = true })

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

      vim.keymap.set("n", "!", [[#*<Cmd>lua require('hlslens').start()<CR>]], { desc = "Search current word" })
      vim.keymap.set("v", "!", [[y<ESC>/<c-r>"<CR>]], { desc = "Search selection" })
    end,
  },
  -- { 'RaafatTurki/corn.nvim', config = true }
}
