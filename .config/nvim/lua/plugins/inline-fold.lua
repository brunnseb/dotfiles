return {

  {
    'malbertzard/inline-fold.nvim',
    keys = { { '<leader>ui', '<cmd>InlineFoldToggle<CR>', desc = 'Toggle inline fold' } },
    enabled = false,
    event = 'BufEnter',
    opts = {
      defaultPlaceholder = '…',
      queries = {
        html = {
          { pattern = 'class="([^"]*)"', placeholder = '@' }, -- classes in html
          { pattern = 'href="(.-)"' }, -- hrefs in html
          { pattern = 'src="(.-)"' }, -- HTML img src attribute
        },
        typescriptreact = {
          { pattern = 'className="([^"]*)"', placeholder = '@' }, -- classes in tsx
          { pattern = 'href="(.-)"' }, -- hrefs in tsx
          { pattern = 'src="(.-)"' }, -- HTML img src attribute
        },
      },
    },
  },
}
