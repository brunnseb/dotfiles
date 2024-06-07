return {

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = false },
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
      { -- optional completion source for require statements and module annotations
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = 'lazydev',
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          })
        end,
      },
    },
    config = function()
      require('neoconf').setup()

      vim.diagnostic.config {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '●',
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

          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
          map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
          map('gy', require('fzf-lua').lsp_typedefs, 'T[y]pe Definition')
          map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>cr', vim.lsp.buf.rename, '[R]ename')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.name == 'tailwindcss' then
            map('<leader>uc', '<cmd>TailwindConcealToggle<CR>', 'Toggle tailwind conceal')
            map('<leader>ct', '<cmd>TailwindSort<CR>', 'Sort tailwind classes')
            map('[c', '<cmd>TailwindPrevClass<CR>', 'Go to previous class')
            map(']c', '<cmd>TailwindNextClass<CR>', 'Go to next class')
          end

          if client and client.name == 'typescript-tools' then
            map('<leader>co', '<cmd>TSToolsOrganizeImports<CR>', 'Organize imports')
            map('<leader>ci', '<cmd>TSToolsAddMissingImports<CR>', 'Add missing imports')
            map('<leader>cu', '<cmd>TSToolsRemoveUnused<CR>', 'Remove unused')
            map('<leader>cf', '<cmd>TSToolsRenameFile<CR>', 'Rename file')
            map('<leader>cb', '<cmd>CodeActions toggle_arrow_function_braces<CR>', 'Refactor')
          end

          if client and client.name == 'tsserver' then
            local applyCodeAction = function(code_action)
              vim.lsp.buf.code_action {
                apply = true,
                context = {
                  only = { code_action },
                  diagnostics = {},
                },
              }
            end
            map('<leader>co', function()
              applyCodeAction 'source.organizeImports.ts'
            end, 'Organize imports')
            map('<leader>ci', function()
              applyCodeAction 'source.addMissingImports.ts'
            end, 'Add missing imports')
            map('<leader>cu', function()
              applyCodeAction 'source.removeUnused.ts'
            end, 'Remove unused')
            map('<leader>cb', '<cmd>CodeActions toggle_arrow_function_braces<CR>', 'Refactor')
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

      local inlay_hints_settings = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'literal',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      }

      local servers = {
        tsserver = {
          settings = {
            typescript = {
              inlayHints = inlay_hints_settings,
            },
            javascript = {
              inlayHints = inlay_hints_settings,
            },
            completions = {
              completeFunctionCalls = true,
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
            format = 'false',
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
