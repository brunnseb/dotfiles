return {
  {
    -- Code companion configuration with various strategies and adapters
    "olimorris/codecompanion.nvim",
    -- Key mappings for code companion chat interface
    cmd = { "CodeCompanionChat", "CodeCompanion", "CodeCompanionActions" },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "New chat" },
    },
    -- Plugin dependencies for proper functionality
    dependencies = {
      { "echasnovski/mini.diff", version = "*" },
      { "nvim-lua/plenary.nvim", branch = "master" },
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion", "Avante" },
        opts = { render_modes = true, file_types = { "markdown", "codecompanion", "Avante" } },
      },
    },
    -- Configure code companion plugin with custom options
    config = function()
      require("codecompanion").setup({
        opts = {},
        -- Display configuration for chat and diff interface
        display = {
          diff = {
            provider = "mini_diff",
          },
        },
        strategies = {
          -- Chat strategy configuration with key bindings and behavior
          chat = {
            adapter = "llama-swap",
          },

          -- Inline strategy configuration for code completion and suggestions
          inline = {
            adapter = "llama-swap",
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
        prompt_library = {
          ["My New Prompt"] = {
            strategy = "chat",
            description = "Some cool custom prompt you can do",
            prompts = {
              {
                role = "system",
                content = "Enable deep thinking subroutine.",
              },
              {
                role = "user",
                content = "",
              },
            },
          },
        },
        -- Adapter configurations for different AI providers
        adapters = {
          opts = {
            show_defaults = false,
          },
          -- Configuration for Qwen Coder adapter with custom parameters
          ["llama-swap"] = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = {
                  default = "rombo",
                },
              },
              env = {
                url = "http://ai:8080",
                chat_url = "/v1/chat/completions",
                api_key = vim.fn.expand("$TABBY_API_KEY"),
              },
              headers = {
                ["Content-Type"] = "application/json",
              },
              parameters = {},
              handlers = {
                chat_output = function(self, data)
                  local openai = require("codecompanion.adapters.openai")
                  local result = openai.handlers.chat_output(self, data)
                  if result ~= nil then
                    result.output.role = "llm" -- "assistant"  works as well
                  end
                  return result
                end,
              },
            })
          end,
        },
      })
    end,
  },
}
