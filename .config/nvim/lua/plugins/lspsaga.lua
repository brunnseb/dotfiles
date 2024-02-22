return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        -- symbol_in_winbar = {
        --   enable = true,
        -- },
        finder = {
          layout = "normal",
          max_height = 0.2,
          silent = true,
          default = "ref",
        },
      })
    end,
    keys = {
      { "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to definition" },
      { "gr", "<cmd>Lspsaga finder<CR>", desc = "Finder" },
      { "gy", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek type definition" },
      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover" },
      { "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
