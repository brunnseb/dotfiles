local formatter_filetypes = { 'lua', 'scss', 'css', 'json' }

return {
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
