return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          require("none-ls.code_actions.eslint_d"),
        },
      })
    end,
  },
  {

    "mfussenegger/nvim-lint",
    opts = {
      events = { "BufWritePost", "BufReadPost" },
      linters_by_ft = {
        fish = { "fish" },
        typescriptreact = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        javascript = { "eslint_d" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
        -- ["*"] = { "typos" },
      },
      -- LazyVim extension to easily override linter options
      -- or add custom linters.
      ---@type table<string,table>
      linters = {
        -- -- Example of using selene only when a selene.toml file is present
        -- selene = {
        --   -- `condition` is another LazyVim extension that allows you to
        --   -- dynamically enable/disable linters based on the context.
        --   condition = function(ctx)
        --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
  },
  {
    "jake-stewart/multicursor.nvim",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      -- set({ "n", "x" }, "<up>", function()
      --   mc.lineAddCursor(-1)
      -- end)
      -- set({ "n", "x" }, "<down>", function()
      --   mc.lineAddCursor(1)
      -- end)
      -- set({ "n", "x" }, "<leader><up>", function()
      --   mc.lineSkipCursor(-1)
      -- end)
      -- set({ "n", "x" }, "<leader><down>", function()
      --   mc.lineSkipCursor(1)
      -- end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<C-n>", function()
        mc.matchAddCursor(1)
      end)
      set({ "n", "x" }, "<leader>s", function()
        mc.matchSkipCursor(1)
      end)
      set({ "n", "x" }, "<S-C-n>", function()
        mc.matchAddCursor(-1)
      end)
      set({ "n", "x" }, "<leader>S", function()
        mc.matchSkipCursor(-1)
      end)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    opts = {},
  },
  {
    "pablopunk/pi.nvim",
    opts = {
      provider = "llama.cpp", -- Use local llama.cpp server for AI inference
      model = "qwen3.6-35b", -- Qwen 3.6 27B parameter model
      binary = "omp", -- Oh My Pi CLI binary
    },
  },
  -- Sidekick: AI assistant panel with tmux multiplexing support
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        win = {
          keys = {
            prompt = { "<a-l>", "prompt", mode = "t" }, -- Alt+L opens prompt in terminal mode
          },
        },
        mux = {
          backend = "tmux",
          enabled = true, -- Use tmux for session persistence across windows
        },
        tools = {
          pi = {
            cmd = { "pi" }, -- Register pi as a sidekick tool
          },
          omp = {
            cmd = { "omp" },
          },
        },
      },
    },
    keys = {
      -- Focus the sidekick panel from any mode
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        desc = "Sidekick Focus",
        mode = { "n", "t", "i", "x" },
      },
      -- Toggle the sidekick panel open/closed
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      -- Select which AI tool/agent to use
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        desc = "Select CLI",
      },
      -- Close/detach the current CLI session
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      -- Send selected text or current line to the AI
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      -- Send the entire file to the AI
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      -- Send visual selection to the AI
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      -- Open a prompt for user input in the sidekick panel
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
    },
  },
}
