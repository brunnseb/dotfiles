return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require 'which-key'
      wk.setup()

      wk.add({

        { '<leader>a', group = '[A]I' },
        { '<leader>a_', hidden = true },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>bD', group = '[D]iff' },
        { '<leader>bD_', hidden = true },
        { '<leader>b_', hidden = true },
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>d_', hidden = true },
        { '<leader>f', group = '[F]ile' },
        { '<leader>f_', hidden = true },
        { '<leader>g', group = '[G]it' },
        { '<leader>g_', hidden = true },
        { '<leader>o', group = '[O]verseer' },
        { '<leader>o_', hidden = true },
        { '<leader>p', group = '[P]roject' },
        { '<leader>p_', hidden = true },
        { '<leader>q', group = 'Session' },
        { '<leader>q_', hidden = true },
        { '<leader>r', group = 'T[r]anslate' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
        { '<leader>t', group = '[T]est' },
        { '<leader>t_', hidden = true },
        { '<leader>u', group = '[U]I' },
        { '<leader>u_', hidden = true },
        { '<leader>w', group = '[W]indows' },
        { '<leader>w_', hidden = true },
        { '<leader>x', group = 'Fi[x]' },
        { '<leader>x_', hidden = true },
      }, { mode = 'n' })

      wk.add({

        { '<leader>a', group = '[A]I' },
        { '<leader>a_', hidden = true },
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>g', group = '[G]it' },
        { '<leader>g_', hidden = true },
        { '<leader>r', group = 'T[r]anslate' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
      }, { mode = 'v' })

      -- wk.register({
      --   ['<leader>a'] = { name = '[A]I', _ = 'which_key_ignore' },
      --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      --   ['<leader>r'] = { name = 'T[r]anslate', _ = 'which_key_ignore' },
      --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      --   ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      -- }, { mode = 'v' })
    end,
  },
}
