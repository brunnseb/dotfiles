return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat<CR>",
        desc = "New Chat",
      },
    },
    opts = {
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
      adapters = {
        acp = {
          opts = {
            show_defaults = false,
          },
        },
        http = {
          llamacpp = function()
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
                api_key = vim.fn.expand("$TABBY_API_KEY"),
                models_endpoint = "/v1/models",
              },
              headers = {
                ["Content-Type"] = "application/json",
              },
              parameters = {},
            })
          end,
          opts = {
            show_model_choices = true,
            show_defaults = false,
          },
          -- Define your custom adapters here
        },
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
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ravitemer/mcphub.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
      },
    },
  },
}
