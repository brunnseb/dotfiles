return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanionChat", "CodeCompanion" },
    dependencies = {
      "j-hui/fidget.nvim",
      "lalitmee/codecompanion-spinners.nvim",
      "ravitemer/codecompanion-history.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
        config = function()
          require("render-markdown").setup({
            html = {
              enabled = true,
              tag = {
                -- Icons and highlights for different message types in the chat interface
                buf = { icon = " ", highlight = "CodeCompanionChatVariable" },
                file = { icon = " ", highlight = "CodeCompanionChatVariable" },
                group = { icon = " ", highlight = "CodeCompanionChatToolGroup" },
                help = { icon = "󰘥 ", highlight = "CodeCompanionChatVariable" },
                image = { icon = " ", highlight = "CodeCompanionChatVariable" },
                symbols = { icon = " ", highlight = "CodeCompanionChatVariable" },
                tool = { icon = " ", highlight = "CodeCompanionChatTool" },
                url = { icon = "󰖟 ", highlight = "CodeCompanionChatVariable" },
                user_prompt = { icon = " ", highlight = "CodeCompanionChatTool" },
                var = { icon = " ", highlight = "CodeCompanionChatVariable" },
              },
            },
          })
        end,
      },
    },
    keys = {
      { "<leader>ac", ":CodeCompanion", desc = "CodeCompanion", mode = { "n", "x" } },
    },
    opts = function()
      local layout = vim.env.CC_LAYOUT_OVERRIDE or "vertical"
      return {
        prompt_library = {
          markdown = {
            dirs = {
              "/home/brunnseb/.config/prompts",
            },
          },
        },
        display = {
          chat = {
            window = {
              layout = layout,
            },
          },
          diff = {
            enabled = false,
            -- provider_opts = {
            --   inline = {
            --     enabled = false,
            --   },
            -- },
          },
        },
        adapters = {
          acp = {

            cursor_cli = function()
              return {
                name = "cursor_cli",
                formatted_name = "Cursor CLI",
                type = "acp",
                roles = {
                  llm = "assistant",
                  user = "user",
                },
                commands = {
                  default = { "pi-acp" },
                },
                defaults = {
                  timeout = 20000,
                },
                parameters = {
                  protocolVersion = 1,
                  clientCapabilities = {
                    fs = { readTextFile = true, writeTextFile = true },
                  },
                  clientInfo = {
                    name = "CodeCompanion.nvim",
                    version = "1.0.0",
                  },
                },
                handlers = {
                  setup = function(self)
                    vim.notify("Launching Cursor CLI")
                    return true
                  end,

                  auth = function(self)
                    return true
                  end,

                  form_messages = function(self, messages, capabilities)
                    return codecompanion_helpers.form_messages(self, messages, capabilities)
                  end,

                  on_exit = function(self, code) end,
                },
              }
            end,
            opencode = function()
              return require("codecompanion.adapters").extend("opencode", {
                -- env = {
                --   CLAUDE_CODE_OAUTH_TOKEN = "my-oauth-token",
                -- },
              })
            end,
            opts = {
              show_presets = false,
            },
          },
          http = {
            ai = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                schema = {
                  keep_alive = {
                    default = "5m",
                  },
                  model = {
                    default = "qwen3.5-27b",
                  },
                },
                env = {
                  -- api_key = vim.fn.expand("$TABBY_API_KEY"),
                  chat_url = "/v1/chat/completions",
                  models_endpoint = "/v1/models",
                  url = "http://100.64.0.5:8080",
                },
                headers = {
                  ["Content-Type"] = "application/json",
                },
                parameters = {},
              })
            end,
            opts = {
              show_model_choices = true,
              show_presets = false,
            },
            -- Define your custom adapters here
          },
        },
        extensions = {
          spinner = {
            opts = {
              -- Your spinner configuration goes here
              style = "fidget",
            },
          },
        },
        strategies = {
          chat = {
            adapter = "ai",
          },
          inline = {
            adapter = "ai",
          },
          cmd = {
            adapter = "ai",
          },
        },
      }
    end,
  },
}
