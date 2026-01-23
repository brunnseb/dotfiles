return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      {
        "Davidyz/VectorCode",
        version = "*", -- optional, depending on whether you're on nightly or release
        dependencies = { "nvim-lua/plenary.nvim" },
      },
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
    opts = function()
      local layout = vim.env.CC_LAYOUT_OVERRIDE or "vertical"
      return {
        display = {
          chat = {
            window = {
              layout = layout,
            },
          },
          diff = {
            provider_opts = {
              inline = {
                layout = "buffer",
              },
            },
          },
        },
        adapters = {
          acp = {
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
            llamacpp = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                schema = {
                  keep_alive = {
                    default = "5m",
                  },
                  model = {
                    default = "gpt-oss-120",
                  },
                  think = {
                    default = false,
                  },
                },
                env = {
                  -- api_key = vim.fn.expand("$TABBY_API_KEY"),
                  chat_url = "/v1/chat/completions",
                  models_endpoint = "/v1/models",
                  url = "http://100.64.0.2:8080",
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
              style = "native",
            },
          },
        },
        strategies = {
          chat = {
            adapter = "llamacpp",
          },
          inline = {
            adapter = "llamacpp",
          },
          cmd = {
            adapter = "llamacpp",
          },
        },
      }
    end,
  },
}
