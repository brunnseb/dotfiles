local formatter_filetypes = { 'lua', 'scss', 'css', 'json' }

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
    ft = formatter_filetypes,
    config = function()
      local includes = require('utils.utils').includes
      vim.api.nvim_create_autocmd('BufWritePost', {
        callback = function(opts)
          if includes(formatter_filetypes, vim.bo[opts.buf].filetype) then
            vim.cmd 'FormatWrite'
          end
        end,
      })

      require('formatter').setup {
        filetype = {
          lua = {
            require('formatter.filetypes.lua').stylua,
          },
          css = {
            require('formatter.filetypes.css').prettierd,
          },
          scss = {
            require('formatter.filetypes.css').prettierd,
          },
          json = {
            require('formatter.filetypes.css').prettierd,
          },
        },
      }
    end,
  },
}
