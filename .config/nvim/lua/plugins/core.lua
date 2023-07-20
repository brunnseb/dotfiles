return {

  {
    'nvim-neotest/neotest',
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-vitest',
        },
      }
    end,
    dependencies = {
      'marilari88/neotest-vitest',
    },
  },
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    opts = {
      openai_params = {
        max_tokens = 1000,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'uga-rosa/translate.nvim',
    cmd = { 'Translate' },
    opts = {
      default = {
        output = 'replace',
        parse_before = 'concat,trim,natural',
      },
    },
  },
  {
    'abecodes/tabout.nvim',
    dependencies = { 'nvim-treesitter' },
    event = 'VeryLazy',
  },
  {
    'gaelph/logsitter.nvim',
    ft = { 'typescriptreact', 'typescript', 'javascript', 'javascriptreact', 'lua' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'axelvc/template-string.nvim',
    event = 'User AstroFile',
    config = true,
  },
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    opts = {},
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require 'statuscol.builtin'
          require('statuscol').setup {
            relculright = true,
            segments = {
              {
                text = { builtin.foldfunc },
                click = 'v:lua.ScFa',
              },
              {
                text = { ' %s' },
                click = 'v:lua.ScSa',
              },
              {
                text = { builtin.lnumfunc, ' ' },
                condition = { true, builtin.not_empty },
                click = 'v:lua.ScLa',
              },
            },
          }
        end,
      },
    },
    config = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ('  %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end

      require('ufo').setup {
        fold_virt_text_handler = handler,
        ---@diagnostic disable-next-line: assign-type-mismatch
        close_fold_kinds = { 'imports', 'comment' },

        provider_selector = function()
          return { 'treesitter', 'indent' }
        end,
      }
      -- buffer scope handler
      -- will override global handler if it is existed
      local bufnr = vim.api.nvim_get_current_buf()
      require('ufo').setFoldVirtTextHandler(bufnr, handler)
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = {
      result_padding = ' ↪  ',
      mapping = {
        run_replace = { map = 'R' },
        run_current_replace = { map = 'C' },
        send_to_qf = {
          map = 'Q',
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = 'send all item to quickfix',
        },
      },
    },
  },
  { 'lambdalisue/suda.vim', cmd = { 'SudaWrite', 'SudaRead' } },
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
          javascript = 'rainbow-parens',
          tsx = 'rainbow-parens',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
  { 'gbprod/yanky.nvim', opts = {}, event = 'VeryLazy' },
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      local lga_actions = require 'telescope-live-grep-args.actions'
      local actions = require 'telescope.actions'

      local opts = {
        defaults = {
          -- prompt_prefix = get_icon('Selected', 1),
          -- selection_caret = get_icon('Selected', 1),
          path_display = { 'truncate' },
          sorting_strategy = 'ascending',
          layout_config = {
            horizontal = { prompt_position = 'top', preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-h>'] = actions.to_fuzzy_refine,
              ['<C-u>'] = false,
              ['<esc>'] = actions.close,
              ['<c-d>'] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-'>"] = lga_actions.quote_prompt(),
              },
            },
          },
        },
      }

      require('telescope').setup(opts)

      require('telescope').load_extension 'live_grep_args'
      require('telescope').load_extension 'fzf'
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      icons = {
        separator = '',
        group = '',
      },
      plugins = { presets = { operators = true } },
    },
  },
  {
    'rcarriga/nvim-notify',
    opts = {
      top_down = false,
      max_height = function()
        return math.floor(vim.o.lines * 0.3)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.3)
      end,
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      lsp = {
        progress = {
          enabled = true,
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = { event = 'notify', find = 'No information available' },
          opts = { skip = true },
        },
      },
    },
  },
  {
    'folke/edgy.nvim',
    opts = function(_, opts)
      if not opts.bottom then
        opts.bottom = {}
      end
      table.insert(opts.bottom, {
        ft = 'noice',
        size = { height = 0.4 },
        filter = function(_, win)
          return vim.api.nvim_win_get_config(win).relative == ''
        end,
      })
      table.insert(opts.bottom, { ft = 'spectre_panel', title = 'Search/Replace', size = { height = 0.4 } })
    end,
  },
  {
    'notjedi/nvim-rooter.lua',
    lazy = false,
    opts = {
      rooter_patterns = { '=hypr', '=eww', '=astronvim', '=nvim', 'package.json', '.vscode', '.git' },
      trigger_patterns = { '*' },
      manual = false,
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    opts = function()
      local function on_file_remove(args)
        local vtsls_clients = vim.lsp.get_active_clients { name = 'vtsls' }
        for _, vtsls_client in ipairs(vtsls_clients) do
          vtsls_client.notify('workspace/didRenameFiles', {
            files = {
              {
                oldUri = vim.uri_from_fname(args.source),
                newUri = vim.uri_from_fname(args.destination),
              },
            },
          })
        end
      end

      local events = require 'neo-tree.events'

      return {
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
        },
        event_handlers = {
          {
            event = events.FILE_MOVED,
            handler = on_file_remove,
          },
          {
            event = events.FILE_RENAMED,
            handler = on_file_remove,
          },
        },
      }
    end,
  },
}
