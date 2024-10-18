return {
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
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
