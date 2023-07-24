return {
  {
    'nvim-pack/nvim-spectre',
    event = 'BufEnter',
    opts = {
      result_padding = ' ↪  ',
      mapping = {
        run_replace = { map = 'R' },
        run_current_replace = { map = 'C' },
        send_to_qf = {
          map = 'Q',
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = 'send all item to quickfix',
        },
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      icons = {
        separator = '',
        group = '',
      },
      plugins = { presets = { operators = true } },
    },
  },
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    opts = {
      openai_params = {
        max_tokens = 1000,
      },
      edit_with_instructions = {
        keymaps = {
          close = '<Esc>',
        },
      },
      chat = {
        keymaps = {
          close = '<Esc>',
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'uga-rosa/translate.nvim',
    cmd = { 'Translate' },
    opts = {
      default = {
        output = 'replace',
        parse_before = 'concat,trim,natural',
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
}
