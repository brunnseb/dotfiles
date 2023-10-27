return {
  {
    'dnlhc/glance.nvim',
    config = function()
      require('glance').setup {
        -- your configuration
      }
    end,
  },
  {
    'ckolkey/ts-node-action',
    dependencies = { 'nvim-treesitter' },
    opts = {},
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
    'hinell/lsp-timeout.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  },
  {
    'ecthelionvi/NeoComposer.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
    opts = {
      keymaps = {
        play_macro = 'Q',
        yank_macro = 'yq',
        stop_macro = 'cq',
        toggle_record = 'q',
        cycle_next = ']q',
        cycle_prev = '[q',
        toggle_macro_menu = '<leader>q',
      },
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
          nls.builtins.code_actions.ts_node_action,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.eslint_d,
          nls.builtins.formatting.prettierd,
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
  },
  -- {
  --   'nvimdev/lspsaga.nvim',
  --   event = 'LspAttach',
  --   config = function()
  --     require('lspsaga').setup {}
  --   end,
  --   dependencies = {
  --     { 'nvim-tree/nvim-web-devicons' },
  --     { 'nvim-treesitter/nvim-treesitter' },
  --   },
  -- },
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
  { 'gbprod/yanky.nvim',     opts = {}, event = 'VeryLazy' },
}
