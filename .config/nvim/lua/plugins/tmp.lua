return {
  {
    dir = '/home/brunnseb/Development/bropilot.nvim/',
    -- 'meeehdi-dev/bropilot.nvim',
    event = 'VeryLazy', -- preload model on start
    dependencies = {
      'nvim-lua/plenary.nvim',
      'j-hui/fidget.nvim',
    },
    opts = {
      auto_suggest = true,
      excluded_filetypes = { 'something', 'codecompanion', 'gitcommit' },
      model = 'qwen2.5-coder:1.5b-base-fp16',
      model_params = {
        num_ctx = 16384,
        num_predict = -2,
        temperature = 0,
        top_p = 0.95,
        stop = { '<|fim_pad|>', '<|endoftext|>' },
      },
      -- model_params = {
      --   mirostat = 0,
      --   mirostat_eta = 0.1,
      --   mirostat_tau = 5.0,
      --   num_ctx = 2048,
      --   repeat_last_n = 64,
      --   repeat_penalty = 1.1,
      --   temperature = 0.8,
      --   seed = 0,
      --   stop = {},
      --   tfs_z = 1,
      --   num_predict = 128,
      --   top_k = 40,
      --   top_p = 0.9,
      --   min_p = 0.0,
      -- },
      prompt = {
        prefix = '<|fim_prefix|>',
        suffix = '<|fim_suffix|>',
        middle = '<|fim_middle|>',
      },
      debounce = 500, -- careful with this setting when auto_suggest is enabled, can lead to curl jobs overload
      keymap = {
        accept_word = '<C-Right>',
        accept_line = '<S-Right>',
        accept_block = '<C-Up>',
        suggest = '<C-Down>',
      },
      ollama_url = 'http://media:7869/api',
    },
    config = function(_, opts)
      require('bropilot').setup(opts)
    end,
  },
  {
    'chrisgrieser/nvim-lsp-endhints',
    event = 'LspAttach',
    opts = {}, -- required, even if empty
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    config = function()
      require('tiny-inline-diagnostic').setup()
    end,
  },
  {
    'jiaoshijie/undotree',
    dependencies = { { 'nvim-lua/plenary.nvim', branch = 'master' } },
    config = function()
      local undotree = require 'undotree'

      undotree.setup {
        float_diff = false, -- using float window previews diff, set this `true` will disable layout option
        layout = 'left_bottom', -- "left_bottom", "left_left_bottom"
        position = 'left', -- "right", "bottom"
        ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
        window = {
          winblend = 30,
        },
        keymaps = {
          ['<down>'] = 'move_next',
          ['<up>'] = 'move_prev',
          ['g<down>'] = 'move2parent',
          ['<S-down>'] = 'move_change_next',
          ['<S-up>'] = 'move_change_prev',
          ['<cr>'] = 'action_enter',
          ['i'] = 'enter_diffbuf',
          ['q'] = 'quit',
        },
      }
    end,
    keys = { -- load the plugin only when using it's keybinding:
      { '<leader>uu', "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  {
    'chrisgrieser/nvim-chainsaw',
    keys = {
      { '<leader>lv', '<cmd>lua require("chainsaw").variableLog()<CR>', desc = '[L]og [V]ariable' },
      { '<leader>lt', '<cmd>lua require("chainsaw").typeLog()<CR>', desc = '[L]og [T]ype' },
      { '<leader>la', '<cmd>lua require("chainsaw").assertLog()<CR>', desc = '[L]og [A]ssertion' },
      { '<leader>le', '<cmd>lua require("chainsaw").emojiLog()<CR>', desc = '[L]og [E]moji' },
      { '<leader>lm', '<cmd>lua require("chainsaw").messageLog()<CR>', desc = '[L]og [M]essage' },
      { '<leader>ld', '<cmd>lua require("chainsaw").debugLog()<CR>', desc = '[L]og [D]ebug' },
      { '<leader>lT', '<cmd>lua require("chainsaw").timeLog()<CR>', desc = '[L]og [T]ime' },
      { '<leader>ls', '<cmd>lua require("chainsaw").stacktraceLog()<CR>', desc = '[L]og [S]tacktrace' },
      { '<leader>lr', '<cmd>lua require("chainsaw").removeLogs()<CR>', desc = '[R]emove [L]ogs' },
    },
  },
  {
    'jackMort/tide.nvim',
    config = function()
      require('tide').setup {
        -- optional configuration
      }
    end,
    requires = {
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'chrisgrieser/nvim-scissors',
    dependencies = { 'stevearc/dressing.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {
      snippetDir = vim.fn.stdpath 'config' .. '/snippets',
    },
  },
}
