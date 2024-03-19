return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]ile', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>o'] = { name = '[O]llama', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
        ['<leader>u'] = { name = '[U]I', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Fi[x]', _ = 'which_key_ignore' },
        ['<leader>q'] = { name = 'Session', _ = 'which_key_ignore' },
        ['<leader>p'] = { name = '[P]roject', _ = 'which_key_ignore' },
      }
    end,
  },
}
