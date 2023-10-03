return {
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
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local colors = {
        blue = '#0088fe',
        cyan = '#90EBED',
        black = '#21425c',
        white = '#E2EFFE',
        red = '#D45A7E',
        violet = '#00C8A0',
        grey = '#1A3549',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.black, bg = colors.black },
        },

        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.black, bg = colors.black },
        },
      }

      require('lualine').setup {
        options = {
          theme = bubbles_theme,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = { 'filename', 'branch' },
          lualine_c = { 'fileformat' },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {
          lualine_a = { 'buffers' },
          lualine_b = { 'branch' },
          lualine_c = { 'filename' },
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'tabs' },
        },
        extensions = { 'neo-tree', 'lazy', 'trouble', 'quickfix' },
      }
    end,
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
      messages = {
        -- view = 'messages',
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
        {
          filter = { event = 'msg_show', cmdline = true, error = false, warning = false },
          view = 'messages',
        },
        {
          filter = {
            event = 'notify',
            kind = 'warn',
            find = 'for_each_child',
          },
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
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = 'ibl',
    opts = {
      -- char = '┃',
      show_trailing_blankline_indent = true,
      -- strict_tabs = true,
      char = '│',
      context_char = '│',
      show_current_context = true,
      -- show_current_context_start = true,
    },
  },
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        names = true,
        tailwind = true,
      },
    },
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
}
