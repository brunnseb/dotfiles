return {
  {
    'smjonas/inc-rename.nvim',
    opts = {},
    keys = {
      {
        '<leader>cr',
        function()
          return ':IncRename ' .. vim.fn.expand '<cword>'
        end,
        desc = 'Rename',
        expr = true,
      },
    },
  },
  { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, opts = {} },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup { lightbulb = { enable = false } }
    end,
    event = 'LspAttach',
    keys = {
      { '<leader>cf', '<cmd>Lspsaga finder<CR>', desc = 'Finder' },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'yioneko/nvim-vtsls',
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
      {

        'iguanacucumber/magazine.nvim',
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = 'lazydev',
            group_index = 0,
          })
        end,
      },
    },
    config = function()
      -- require('neoconf').setup()

      vim.diagnostic.config {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        virtual_lines = {
          only_current_line = true,
          highlight_whole_line = false,
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
          },
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            local m = mode or 'n'
            vim.keymap.set(m, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', '<cmd>Lspsaga goto_definition<CR>', '[G]oto [D]efinition')
          map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
          map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
          map('gy', '<cmd>Lspsaga goto_type_definition<CR>', 'T[y]pe Definition')
          map('<leader>ca', '<cmd>FzfLua lsp_code_actions previewer=false<CR>', '[C]ode [A]ction', { 'n', 'x' })
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.name == 'tailwindcss' then
            map('<leader>uc', '<cmd>TailwindConcealToggle<CR>', 'Toggle tailwind conceal')
            map('<leader>ct', '<cmd>TailwindSort<CR>', 'Sort tailwind classes')
            map('[C', '<cmd>TailwindPrevClass<CR>', 'Go to previous class')
            map(']C', '<cmd>TailwindNextClass<CR>', 'Go to next class')
          end

          if client and client.name == 'vtsls' then
            require('lspconfig.configs').vtsls = require('vtsls').lspconfig

            map('<leader>co', '<cmd>VtsExec organize_imports<CR>', 'Organize imports')
            map('<leader>ci', '<cmd>VtsExec add_missing_imports<CR>', 'Add missing imports')
            map('<leader>cu', '<cmd>VtsExec remove_unused<CR>', 'Remove unused')
            map('<leader>cF', '<cmd>VtsExec rename_file<CR>', 'Rename file')
            map('<leader>cs', '<cmd>VtsExec source_actions<CR>', 'Source actions')
            map('<leader>cR', '<cmd>VtsExec restart_tsserver<CR>', 'Restart server')
          end

          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      })

      local servers = {
        vtsls = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
        cssls = {
          settings = {
            css = { validate = true, lint = {
              unknownAtRules = 'ignore',
            } },
            scss = { validate = true, lint = {
              unknownAtRules = 'ignore',
            } },
            less = { validate = true, lint = {
              unknownAtRules = 'ignore',
            } },
          },
        },
        eslint = {
          settings = {
            workingDirectories = { mode = 'auto' },
            format = false,
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        tailwindcss = {
          filetypes = {
            'astro',
            'handlebars',
            'html',
            'css',
            'less',
            'postcss',
            'sass',
            'scss',
            'javascriptreact',
            'reason',
            'rescript',
            'typescriptreact',
            'vue',
            'svelte',
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'cssls',
        'jsonls',
        'bashls',
        'tailwindcss',
        'docker_compose_language_service',
        'html',
        'yamlls',
        'eslint',
        'js-debug-adapter',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
