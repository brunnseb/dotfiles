return {
  {
    'mg979/vim-visual-multi',
    event = 'BufEnter',
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {
        ui = {
          kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
        },
      }
    end,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
  },
  {
    'mhartington/formatter.nvim',
    ft = { 'lua' },
    config = function()
      vim.api.nvim_create_autocmd('BufWritePost', {
        callback = function(opts)
          if vim.bo[opts.buf].filetype == 'lua' then
            vim.cmd 'FormatWrite'
          end
        end,
      })

      require('formatter').setup {
        filetype = {
          lua = {
            require('formatter.filetypes.lua').stylua,
          },
        },
      }
    end,
  },
}
