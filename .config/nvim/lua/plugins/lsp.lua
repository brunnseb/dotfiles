return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = false },
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      require('neoconf').setup()

      local baseDefinitionHandler = vim.lsp.handlers['textDocument/definition']
      local filter = require('utils.filter').filter
      local filterReactDTS = require('utils.filter').filterReactDTS

      local handlers = {
        ['textDocument/definition'] = function(err, result, method, ...)
          if vim.tbl_islist(result) and #result > 1 then
            local filtered_result = filter(result, filterReactDTS)
            return baseDefinitionHandler(err, filtered_result, method, ...)
          end

          baseDefinitionHandler(err, result, method, ...)
        end,
        ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = true,
          virtual_text = {
            spacing = 5,
            min = 'Warning',
          },
          update_in_insert = true,
        }),
        -- ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
        --   require('ts-error-translator').translate_diagnostics(err, result, ctx, config)
        --   vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        -- end,
      }

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
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.name == 'tailwindcss' then
            map('<leader>uc', '<cmd>TailwindConcealToggle<CR>', 'Toggle tailwind conceal')
            map('<leader>ct', '<cmd>TailwindSort<CR>', 'Sort tailwind classes')
          end

          if client and client.name == 'vtsls' then
            map('<leader>co', '<cmd>VtsExec organize_imports<CR>', 'Organize imports')
            map('<leader>ci', '<cmd>VtsExec add_missing_imports<CR>', 'Add missing imports')
            map('<leader>cu', '<cmd>VtsExec remove_unused<CR>', 'Remove unused')
            map('<leader>cf', '<cmd>VtsExec rename_file<CR>', 'Rename file')
            map('<leader>cs', '<cmd>VtsExec restart_tsserver<CR>', 'Restart tsserver')
            map('<leader>cR', '<cmd>CodeActions all<CR>', 'Refactor')
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

          local status_ok, codelens_supported = pcall(function()
            return client and client.supports_method 'textDocument/codeLens'
          end)
          if not status_ok or not codelens_supported then
            return
          end
          local group = 'lsp_code_lens_refresh'
          local cl_events = { 'BufEnter', 'InsertLeave' }
          local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
            group = group,
            buffer = event.buf,
            event = cl_events,
          })

          if ok and #cl_autocmds > 0 then
            return
          end
          vim.api.nvim_create_augroup(group, { clear = false })
          vim.api.nvim_create_autocmd(cl_events, {
            group = group,
            buffer = event.buf,
            callback = vim.lsp.codelens.refresh,
          })
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      })

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        vtsls = {
          handlers = handlers,
          settings = {
            vtsls = { autoUseWorkspaceTsdk = true },
            typescript = {
              referencesCodeLens = { enabled = true, showOnAllFunctions = true },
              implementationsCodeLens = { enabled = true, showOnInterfaceMethods = true },
              inlayHints = {
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              preferences = {
                useAliasesForRenames = false,
                renameShorthandProperties = false,
              },
            },
          },
        },
        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
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
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
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
            'javascript',
            'javascriptreact',
            'reason',
            'rescript',
            'typescript',
            'typescriptreact',
            'vue',
            'svelte',
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
        'vtsls',
        'cssls',
        'jsonls',
        'bashls',
        'cssmodules_ls',
        'tailwindcss',
        'eslint',
        'docker_compose_language_service',
        'html',
        'some-sass-language-server',
        'yamlls',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
