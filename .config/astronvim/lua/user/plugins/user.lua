return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  { "phaazon/hop.nvim", branch = "v2", config = true, event = "User AstroFile" },
  { "chaoren/vim-wordmotion", event = "User AstroFile" },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = {
      inlay_hints = {
        parameter_hints = {
          show = true,
          prefix = " ◀ ",
          separator = ", ",
          remove_colon_start = false,
          remove_colon_end = true,
        },
        type_hints = {
          -- type and other hints
          show = true,
          prefix = "   ",
          separator = ", ",
          remove_colon_start = true,
          remove_colon_end = true,
        },
        only_current_line = false,
        -- separator between types and parameter hints. Note that type hints are
        -- shown before parameter
        labels_separator = "  ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- highlight group
        highlight = "LspInlayHint",
      },
      enabled_at_startup = true,
      debug_mode = false,
    },
  },
  {
    "axelvc/template-string.nvim",
    event = "User AstroFile",
    config = function() require("template-string").setup {} end,
  },
  { "mg979/vim-visual-multi", event = "User AstroFile" },
  { "Pocco81/DAPInstall.nvim" },
  {
    "kylechui/nvim-surround",
    event = "User AstroFile",
    config = true,
  },
  {
    "anuvyklack/windows.nvim",
    cmd = {
      "WindowsMaximize",
      "WindowsMaximizeVertically",
      "WindowsMaximizeHorizontally",
      "WindowsEqualize",
      "WindowsEnableAutowidth",
      "WindowsDisableAutowidth",
      "WindowsToggleAutowidth",
    },
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
  },
  {
    "notjedi/nvim-rooter.lua",
    lazy = false,
    config = function()
      require("nvim-rooter").setup {
        rooter_patterns = { "=cockpit-portal", "=awesome", "=astronvim", "=nvim", "lazy-lock.json", ".vscode", ".git" },
        trigger_patterns = { "*" },
        manual = false,
      }
    end,
  },
}
