return {
  {
    "luukvbaal/nnn.nvim",
    config = true,
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
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {
      openai_params = {
        max_tokens = 1000,
      },
      edit_with_instructions = {
        keymaps = {
          close = "<Esc>",
        },
      },
      chat = {
        keymaps = {
          close = "<Esc>",
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
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
}
