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
          -- Configuration for Qwen Coder adapter with custom parameters
          openai_compatible = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = {
                  default = "qwen3-30",
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
        },
      })
    end,
  },
}
