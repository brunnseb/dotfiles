return {
  {
    dir = vim.fn.expand("$HOME/Development/bropilot.nvim/"),
    -- 'meeehdi-dev/bropilot.nvim',
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "j-hui/fidget.nvim",
    },
    opts = {
      auto_suggest = false,
      model_params = {
        top_p = 0.8,
        top_k = 20,
        repetition_penalty = 1.05,
        temperature = 0.2,
        num_ctx = 8192,
        -- max_tokens = 100,
        -- speculative_ngram = true,
        stop = { "<|fim_pad|>", "<|endoftext|>" },
      },
      -- model_params = {
      --   mirostat = 0,
      --   mirostat_eta = 0.1,
      --   mirostat_tau = 5.0,
      --   repeat_last_n = 64,
      --   repeat_penalty = 1.1,
      --   temperature = 0.8,
      --   seed = 0,
      --   stop = {},
      --   tfs_z = 1,
      --   num_predict = 128,
      --   top_k = 40,
      --   top_p = 0.9,
      --   min_p = 0.0,
      -- },
      prompt = {
        prefix = "<|fim_prefix|>",
        suffix = "<|fim_suffix|>",
        middle = "<|fim_middle|>",
      },
      -- debounce = 500, -- careful with this setting when auto_suggest is enabled, can lead to curl jobs overload
      keymap = {
        accept_word = "<C-Right>",
        accept_line = "<S-Right>",
        accept_block = "<C-Up>",
        suggest = "<C-Down>",
      },
      ollama_url = "http://media:5010/v1",
    },
    config = function(_, opts)
      require("bropilot").setup(opts)
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanionChat", "CodeCompanion" },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "New chat" },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      "nvim-treesitter/nvim-treesitter",
      {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          opts.right = opts.right or {}
          table.insert(opts.right, {
            title = "CodeCompanion",
            ft = "codecompanion",
            size = {
              width = 0.45,
            },
          })
        end,
      },
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
            -- show_settings = true,
            -- render_headers = false,
          },
          diff = {
            -- enabled = true,
          },
        },
        strategies = {
          chat = {
            adapter = "tabby_api_32b",
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
              change_adapter = {
                modes = {
                  n = "gA",
                },
                index = 11,
                callback = "keymaps.change_adapter",
                description = "Change adapter",
              },
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
            },
          },
          inline = {
            adapter = "tabby_api_32b",
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

          ["tabby_api_32b"] = function()
            return require("codecompanion.adapters").extend("openai", {
              schema = {
                model = {
                  -- default = "lucyknada_Qwen_Qwen2.5-Coder-32B-Instruct-exl2",
                  default = "bartwoski_Qwen2.5-Coder-32B-Instruct-exl2",
                },
                top_p = { default = 0.8 },
                top_k = { default = 20 },
                repetition_penalty = { default = 1.05 },
                temperature = { default = 0.2 },
                num_ctx = { default = 16384 },
              },
              url = "http://media:5010/v1/chat/completions",
              env = {
                api_key = "e79fc6f6e89fe2072e20be5a91d57b67",
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
