return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanionChat", "CodeCompanion" },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "New chat" },
    },
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
    config = function()
      local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionInline*",
        group = group,
        callback = function(request)
          vim.notify(vim.inspect(request), nil, { title = "🪚 request", ft = "lua" })

          if request.match == "CodeCompanionInlineFinished" then
            -- Format the buffer after the inline request has completed
            require("conform").format({ bufnr = request.buf })
          end
        end,
      })

      require("codecompanion").setup({
        opts = {},
        display = {
          chat = {
            show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
            start_in_insert_mode = true, -- Open the chat buffer in insert mode?
          },
          diff = {
            provider = "mini_diff",
          },
        },
        strategies = {
          chat = {
            adapter = "qwen_coder",
            keymaps = {
              close = {
                modes = {
                  n = "q",
                },
                index = 3,
                callback = "keymaps.close",
                description = "Close Chat",
              },
              stop = {
                modes = {
                  n = "<C-c>",
                  i = "<C-c>",
                },
                index = 4,
                callback = "keymaps.stop",
                description = "Stop Request",
              },
              codeblock = {
                modes = {
                  n = "gc",
                },
                index = 6,
                callback = "keymaps.codeblock",
                description = "Insert Codeblock",
              },
              -- },
              fold_code = {
                modes = {
                  n = "gf",
                },
                index = 12,
                callback = "keymaps.fold_code",
                description = "Fold code",
              },
              debug = {
                modes = {
                  n = "gd",
                },
                index = 13,
                callback = "keymaps.debug",
                description = "View debug info",
              },
              system_prompt = {
                modes = {
                  n = "<C-;>",
                },
                index = 17,
                callback = "keymaps.toggle_system_prompt",
                description = "Toggle the system prompt",
              },
            },
          },
          inline = {
            adapter = "qwen_coder",
          },
        },
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "ANTHROPIC_API_KEY",
              },
            })
          end,
          ["qwen_coder"] = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = {
                  default = "lucyknada_Qwen_Qwen2.5-Coder-32B-Instruct-exl2",
                },
                -- top_p = { default = 0.8 },
                -- top_k = { default = 20 },
                -- repetition_penalty = { default = 1.05 },
                -- temperature = { default = 0.2 },
                -- num_ctx = { default = 32768 },
              },
              env = {
                url = "http://ai:5010",
                chat_url = "/v1/chat/completions",
                api_key = vim.fn.expand("$TABBY_API_KEY"),
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
