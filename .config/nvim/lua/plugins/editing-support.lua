local filter = function(arr, fn)
  if type(arr) ~= 'table' then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

return {
  {
    'rgroli/other.nvim',
    config = function()
      require('other-nvim').setup {
        rememberBuffers = false,
        mappings = {
          {
            pattern = '(.*)/(.*)/index.ts$',
            target = {
              {
                target = '/%1/%2/%2.tsx',
                context = 'component',
              },
              {
                target = '/%1/%2/%2.test.tsx',
                context = 'test',
              },
              {
                target = '/%1/%2/%2.stories.tsx',
                context = 'story',
              },
            },
          },
          {
            pattern = '(.*)/(.*)/.*.tsx$',
            target = {
              {
                target = '/%1/%2/index.ts',
                context = 'index',
              },
              {
                target = '/%1/%2/%2.test.tsx',
                context = 'test',
              },
              {
                target = '/%1/%2/%2.stories.tsx',
                context = 'story',
              },
            },
          },
        },
      }
    end,
  },
  { 'nvimdev/hlsearch.nvim', event = 'BufRead', config = true },
  {
    'dnlhc/glance.nvim',
    opts = {
      hooks = {
        before_open = function(results, open, jump, method)
          -- Filter out React type declaration files
          local filtered_result = filter(results, function(value)
            -- Depending on typescript version either uri or targetUri is returned
            if value.uri then
              return string.match(value.uri, '%.d.ts') == nil
            elseif value.targetUri then
              return string.match(value.targetUri, '%.d.ts') == nil
            end
          end)
          if #filtered_result == 1 then
            jump(filtered_result[1])
          else
            open(filtered_result)
          end
        end,
      },
    },
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'roobert/action-hints.nvim',
    opts = {
      template = {
        definition = { text = ' ⊛', color = '#add8e6' },
        references = { text = ' ↱%s', color = '#ff6666' },
      },
      use_virtual_text = true,
    },
  },
  {
    'smjonas/inc-rename.nvim',
    config = true,
  },

  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  },
  {
    'chrisgrieser/nvim-recorder',
    dependencies = 'rcarriga/nvim-notify', -- optional
    opts = {
      lessNotifications = true,
    },
  },
  {
    'mg979/vim-visual-multi',
    event = 'BufEnter',
  },
  {
    'nvimtools/none-ls.nvim',
    opts = function()
      local nls = require 'null-ls'
      return {
        sources = {
          -- nls.builtins.formatting.eslint_d,
          nls.builtins.diagnostics.eslint_d,
          nls.builtins.code_actions.eslint_d,
          nls.builtins.code_actions.gitsigns,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.eslint_d,
          -- nls.builtins.formatting.prettierd,
        },
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      }
    end,
    dependencies = {
      {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'nvim-treesitter/nvim-treesitter',
        },
        config = function()
          require('refactoring').setup {
            prompt_func_return_type = {
              ts = true,
              js = true,
            },
            prompt_func_param_type = {
              ts = true,
              js = true,
            },
            printf_statements = {
              ts = true,
              js = true,
            },
            print_var_statements = {
              ts = true,
              js = true,
            },
          }
        end,
      },
    },
  },
  {
    'gaelph/logsitter.nvim',
    event = 'BufEnter',
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = true,
  },
  {
    'chrisgrieser/nvim-spider',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'ge', "<cmd>lua require('spider').motion('ge')<CR>", { desc = 'Spider-ge' })
    end,
  },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'abecodes/tabout.nvim',
    dependencies = { 'nvim-treesitter' },
    event = 'VeryLazy',
  },
  {
    'axelvc/template-string.nvim',
    event = 'BufEnter',
    config = true,
  },
  { 'gbprod/yanky.nvim', opts = {}, event = 'VeryLazy' },
}
