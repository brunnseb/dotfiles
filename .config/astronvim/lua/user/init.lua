return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "catppuccin",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = false,
    virtual_lines = { only_current_line = true, highlight_whole_line = false },
    update_in_insert = false,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
      },
      filter = function(client)
        if
          client.name == "lua_ls"
          or client.name == "tsserver"
          or client.name == "eslint"
          or client.name == "vtsls"
        then
          return false
        end

        return true
      end,
      -- disabled = {      -- disable formatting capabilities for the listed language servers
      --   "tsserver",
      --   "sumneko_lua",
      -- },
      timeout_ms = 2000, -- default format timeout
    },
    config = {
      tsserver = {
        init_options = {
          maxTsServerMemory = 8192,
        },
        root_dir = function(fname) return require("lspconfig.util").root_pattern ".git"(fname) end,
      },
      tailwindcss = {
        root_dir = function(fname) return require("lspconfig.util").root_pattern ".git"(fname) end,
      },
      lua_ls = {
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
          },
        },
      },
      -- vtsls = require("vtsls").lspconfig,
    },
    setup_handlers = {
      vtsls = function(_, opts)
        require("lspconfig").vtsls.setup(vim.tbl_deep_extend("force", opts, {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = {
                  enabled = "all",
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = {
                  enabled = true,
                },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = false,
                },
                propertyDeclarationTypes = {
                  enabled = true,
                },
                functionLikeReturnTypes = {
                  enabled = true,
                },
                enumMemberValues = {
                  enabled = true,
                },
              },
              suggest = {
                completeFunctionCalls = true,
              },
              preferences = {
                importModuleSpecifier = "relative",
                renameShorthandProperties = false,
                useAliasesForRenames = false,
              },
              updateImportsOnFileMove = "always",
              tsserver = {
                maxTsServerMemory = 8192,
                experimental = {
                  enableProjectDiagnostics = true,
                },
              },
              -- preferGoToSourceDefinition = true,
            },
            javascript = {
              inlayHints = {
                parameterNames = {
                  enabled = "all",
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = {
                  enabled = true,
                },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = false,
                },
                propertyDeclarationTypes = {
                  enabled = true,
                },
                functionLikeReturnTypes = {
                  enabled = true,
                },
                enumMemberValues = {
                  enabled = true,
                },
              },
              suggest = {
                completeFunctionCalls = true,
              },
              preferences = {
                importModuleSpecifier = "relative",
                renameShorthandProperties = false,
                useAliasesForRenames = false,
              },
              updateImportsOnFileMove = "always",
              tsserver = {
                maxTsServerMemory = 8192,
                experimental = {
                  enableProjectDiagnostics = true,
                },
              },
              -- preferGoToSourceDefinition = true,
            },
            vtsls = {
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                  entriesLimit = 200,
                },
              },
            },
          },
        }))
      end,
    },
  },
  -- set up UI icons
  icons = {
    ActiveLSP = "",
    ActiveTS = " ",
    BufferClose = "",
    DapBreakpoint = "",
    DapBreakpointCondition = "",
    DapBreakpointRejected = "",
    DapLogPoint = "",
    DapStopped = "",
    DefaultFile = "",
    Diagnostic = "",
    DiagnosticError = "",
    DiagnosticHint = "",
    DiagnosticInfo = "",
    DiagnosticWarn = "",
    Ellipsis = "",
    FileModified = "",
    FileReadOnly = "",
    FoldClosed = "",
    FoldOpened = "",
    FolderClosed = "",
    FolderEmpty = "",
    FolderOpen = "",
    Git = "",
    GitAdd = "",
    GitBranch = "",
    GitChange = "",
    GitConflict = "",
    GitDelete = "",
    GitIgnored = "",
    GitRenamed = "",
    GitStaged = "",
    GitUnstaged = "",
    GitUntracked = "",
    LSPLoaded = "",
    LSPLoading1 = "",
    LSPLoading2 = "",
    LSPLoading3 = "",
    MacroRecording = "",
    Paste = "",
    Search = "",
    Selected = "",
    TabClose = "",
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin", "matchparen" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}
