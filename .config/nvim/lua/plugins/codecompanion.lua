return {
  {
    -- Code companion configuration with various strategies and adapters
    "olimorris/codecompanion.nvim",
    -- Key mappings for code companion chat interface
    cmd = { "CodeCompanionChat", "CodeCompanion", "CodeCompanionActions", "CodeCompanionHistory" },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "New chat" },
    },
    -- Plugin dependencies for proper functionality
    dependencies = {
      {
        "echasnovski/mini.diff",
        config = function()
          local diff = require "mini.diff"
          diff.setup {
            -- Disabled by default
            source = diff.gen_source.none(),
          }
        end,
      },
      { "nvim-lua/plenary.nvim", branch = "master" },
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion", "Avante" },
        opts = { render_modes = true, file_types = { "markdown", "codecompanion", "Avante" } },
      },
      { "ravitemer/codecompanion-history.nvim" },
      {
        "ravitemer/mcphub.nvim",
        branch = "make-tools",
        dependencies = {
          "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
        },
        event = "User AstroFile",
        cmd = "MCPHub",
        opts = {
          port = 3000,
          config = vim.fn.expand "~/mcpservers.json",
          log = {
            level = vim.log.levels.WARN,
            to_file = false,
            file_path = nil,
            prefix = "MCPHub",
          },
        },
      },
      { "j-hui/fidget.nvim" },
    },
    init = function() require("utils.fidget-spinner"):init() end,
    -- Configure code companion plugin with custom options
    config = function()
      require("codecompanion").setup {
        opts = {
          log_level = "TRACE",
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
          history = {
            enabled = true,
            opts = {
              keymap = "gh",
              save_chat_keymap = "sc",
              auto_save = true,
              expiration_days = 0,
              picker = "snacks",
              auto_generate_title = true,
              title_generation_opts = {
                adapter = nil, -- e.g "copilot"
                model = nil, -- e.g "gpt-4o"
              },
              continue_last_chat = false,
              delete_on_clearing_chat = true,
              dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
              enable_logging = false,
            },
          },
        },
        -- Display configuration for chat and diff interface
        display = {
          diff = {
            provider = "mini_diff",
          },
        },
        strategies = {
          -- Chat strategy configuration with key bindings and behavior
          chat = {
            adapter = "openai_compatible",
          },

          -- Inline strategy configuration for code completion and suggestions
          inline = {
            adapter = "openai_compatible",
            keymaps = {
              accept_change = {
                modes = {
                  n = "ga",
                },
                index = 1,
                callback = "keymaps.accept_change",
                description = "Accept change",
              },
              reject_change = {
                modes = {
                  n = "gR",
                },
                index = 2,
                callback = "keymaps.reject_change",
                description = "Reject change",
              },
            },
          },
        },
        prompt_library = {},
        -- Adapter configurations for different AI providers
        adapters = {
          opts = {
            show_model_choices = true,
            show_defaults = false,
          },
          openai_compatible = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = {
                  default = "qwen3-30-coder",
                },
                think = {
                  default = false,
                },
                keep_alive = {
                  default = "5m",
                },
              },
              env = {
                url = "http://ai:8080",
                chat_url = "/v1/chat/completions",
                api_key = vim.fn.expand "$TABBY_API_KEY",
                models_endpoint = "/v1/models",
              },
              headers = {
                ["Content-Type"] = "application/json",
              },
              parameters = {},
            })
          end,
        },
      }
    end,
  },
}
