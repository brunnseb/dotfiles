return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = function()
      return {
        context_commentstring = { enable = true, enable_autocmd = false },
        ensure_installed = {
          'bash',
          'c',
          'lua',
          'markdown',
          'markdown_inline',
          'python',
          'query',
          'vim',
          'vimdoc',
          'tsx',
          'json',
          'scss',
          'css',
          'typescript',
          'javascript',
          'yaml',
          'regex',
          'jsonc',
        },
        highlight = {
          enable = true,
          disable = function(_, bufnr)
            return vim.b[bufnr].large_buf
          end,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gm',
            node_incremental = 'm',
            scope_incremental = 'M',
            node_decremental = 'n',
          },
        },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['ak'] = { query = '@block.outer', desc = 'around block' },
              ['ik'] = { query = '@block.inner', desc = 'inside block' },
              ['ac'] = { query = '@conditional.outer', desc = 'around conditional' },
              ['ic'] = { query = '@conditional.inner', desc = 'inside conditional' },
              ['af'] = { query = '@function.outer', desc = 'around function ' },
              ['if'] = { query = '@function.inner', desc = 'inside function ' },
              ['al'] = { query = '@loop.outer', desc = 'around loop' },
              ['il'] = { query = '@loop.inner', desc = 'inside loop' },
              ['aa'] = { query = '@parameter.outer', desc = 'around argument' },
              ['ia'] = { query = '@parameter.inner', desc = 'inside argument' },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']k'] = { query = '@block.outer', desc = 'Next block start' },
              [']f'] = { query = '@function.outer', desc = 'Next function start' },
              [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
            },
            goto_next_end = {
              [']K'] = { query = '@block.outer', desc = 'Next block end' },
              [']F'] = { query = '@function.outer', desc = 'Next function end' },
              [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
            },
            goto_previous_start = {
              ['[k'] = { query = '@block.outer', desc = 'Previous block start' },
              ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
              ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
            },
            goto_previous_end = {
              ['[K'] = { query = '@block.outer', desc = 'Previous block end' },
              ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
              ['[A'] = { query = '@parameter.inner', desc = 'Previous argument end' },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['>K'] = { query = '@block.outer', desc = 'Swap next block' },
              ['>F'] = { query = '@function.outer', desc = 'Swap next function' },
              ['>A'] = { query = '@parameter.inner', desc = 'Swap next argument' },
            },
            swap_previous = {
              ['<K'] = { query = '@block.outer', desc = 'Swap previous block' },
              ['<F'] = { query = '@function.outer', desc = 'Swap previous function' },
              ['<A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
