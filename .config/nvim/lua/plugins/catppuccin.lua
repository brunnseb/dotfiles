return {
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          blink_cmp = {
            style = "bordered",
          },
          lsp_trouble = true,
          mason = true,
          neotest = true,
          noice = true,
          notify = true,
          rainbow_delimiters = true,
          which_key = true,
          diffview = true,
          nvim_surround = true,
          overseer = true,
          snacks = {
            enabled = true,
            indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
          },
        },
        dim_inactive = { enabled = true, percentage = 0.4 },
        transparent_background = true,
        flavour = "mocha",
        color_overrides = {
          mocha = {
            base = "#252525",
            mantle = "#262626",
            crust = "#252525",
          },
        },
      })

      -- setup must be called before loading
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
