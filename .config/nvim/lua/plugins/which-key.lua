return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require 'which-key'
      wk.setup()

      wk.register({
        ['<leader>a'] = { name = '[A]I', _ = 'which_key_ignore' },
        ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
        ['<leader>bD'] = { name = '[D]iff', _ = 'which_key_ignore' },
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ebug', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = 'T[r]anslate', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]indows', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]ile', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>o'] = { name = '[O]verseer', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
        ['<leader>u'] = { name = '[U]I', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Fi[x]', _ = 'which_key_ignore' },
        ['<leader>q'] = { name = 'Session', _ = 'which_key_ignore' },
        ['<leader>p'] = { name = '[P]roject', _ = 'which_key_ignore' },
      }, { mode = 'n' })

      wk.register({
        ['<leader>a'] = { name = '[A]I', _ = 'which_key_ignore' },
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = 'T[r]anslate', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      }, { mode = 'v' })
    end,
  },
}
