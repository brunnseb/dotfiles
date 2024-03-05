return {
  {
    "yioneko/nvim-vtsls",
    config = function()
      -- vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
      --   vim.notify("showReferences")
      --   local locations = command.arguments[3]
      --   local client = vim.lsp.get_client_by_id(ctx.client_id)
      --   if locations and #locations > 0 then
      --     local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
      --     vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
      --     vim.api.nvim_command("lopen")
      --   end
      -- end
      require("vtsls").config({
        -- customize handlers for commands
        -- handlers = {},
        -- automatically trigger renaming of extracted symbol
        -- refactor_auto_rename = true,
        -- refactor_move_to_file = {
        --   -- If dressing.nvim is installed, telescope will be used for selection prompt. Use this to customize
        --   -- the opts for telescope picker.
        --   telescope_opts = function(items, default) end,
        -- }
      })
    end,
  },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
    keys = {
      { "<leader>wo", "<cmd>WindowsMaximize<CR>", desc = "Maximize" },
      { "<leader>wO", "<cmd>WindowsEqualize<CR>", desc = "Equalize" },
    },
  },
  { "dmmulroy/ts-error-translator.nvim", config = true },
  -- {
  --   "lewis6991/satellite.nvim",
  --   opts = {
  --     width = 50,
  --   },
  -- },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      { "<leader>U", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  {
    "jdrupal-dev/code-refactor.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "CodeActions" },
    keys = {
      { "<leader>cR", "<cmd>CodeActions all<CR>", desc = "Show code-refactor.nvim (not LSP code actions)" },
    },
    config = function()
      require("code-refactor").setup({
        -- Configuration here, or leave empty to use defaults.
      })
    end,
  },
}
