return {
  {
    "hedyhli/outline.nvim",
    keys = { { "<leader>cs", "<cmd>Outline<CR>", desc = "Outline" } },
    cmd = "Outline",
    opts = {
      symbols = {
        icons = {
          File = { icon = "󰈔", hl = "@text.uri" },
          Module = { icon = "󰆧", hl = "@namespace" },
          Namespace = { icon = "󰅪", hl = "@namespace" },
          Package = { icon = "󰏗", hl = "@namespace" },
          Class = { icon = "𝓒", hl = "@type" },
          Method = { icon = "ƒ", hl = "@method" },
          Property = { icon = "", hl = "@method" },
          Field = { icon = "󰆨", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "ℰ", hl = "@type" },
          Interface = { icon = "󰜰", hl = "@type" },
          Function = { icon = "", hl = "@function" },
          Variable = { icon = "", hl = "@constant" },
          Constant = { icon = "", hl = "@constant" },
          String = { icon = "𝓐", hl = "@string" },
          Number = { icon = "#", hl = "@number" },
          Boolean = { icon = "⊨", hl = "@boolean" },
          Array = { icon = "󰅪", hl = "@constant" },
          Object = { icon = "⦿", hl = "@type" },
          Key = { icon = "🔐", hl = "@type" },
          Null = { icon = "NULL", hl = "@type" },
          EnumMember = { icon = "", hl = "@field" },
          Struct = { icon = "𝓢", hl = "@type" },
          Event = { icon = "🗲", hl = "@type" },
          Operator = { icon = "+", hl = "@operator" },
          TypeParameter = { icon = "𝙏", hl = "@parameter" },
          Component = { icon = "󰅴", hl = "@function" },
          Fragment = { icon = "󰅴", hl = "@constant" },
          -- ccls
          TypeAlias = { icon = " ", hl = "@type" },
          Parameter = { icon = " ", hl = "@parameter" },
          StaticMethod = { icon = " ", hl = "@function" },
          Macro = { icon = " ", hl = "@macro" },
        },
      },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = "Outline",
        ft = "Outline",
        pinned = true,
        open = "Outline",
      })
    end,
  },
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
