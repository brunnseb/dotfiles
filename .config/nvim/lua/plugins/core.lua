return {
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
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
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
