return {
  { "max397574/better-escape.nvim", event = "InsertEnter", config = true },
  {
    "johmsalas/text-case.nvim",
    config = true,
  },
  {
    "tpope/vim-sleuth",
    event = "BufEnter",
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
  },
  {
    "luukvbaal/nnn.nvim",
    config = true,
    keys = {
      { "<leader>fn", "<cmd>NnnPicker %:p:h<CR>", desc = "Nnn Picker" },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/home/brunnseb/.config/nvim/lua/snippets" } })
      end,
    },
  },
  {
    "chrisgrieser/nvim-spider",
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "notjedi/nvim-rooter.lua",
    event = "VeryLazy",
    opts = {
      rooter_patterns = {
        "=hypr",
        "=eww",
        "=astronvim",
        "=nvim",
        "package.json",
        -- "turbo.json",
        -- '.vscode',
        -- '.git',
      },
      trigger_patterns = { "*" },
      manual = false,
    },
  },
}
