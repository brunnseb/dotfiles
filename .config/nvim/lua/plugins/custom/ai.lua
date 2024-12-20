return {
  {
    dir = "/home/media/Development/bropilot.nvim/",
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

      -- vim.api.nvim_create_autocmd({ 'User' }, {
      --   pattern = 'CodeCompanionChat*',
      --   group = group,
      --   callback = function(request)
      --     if request.match == 'CodeCompanionChatClosed' or request.match == 'CodeCompanionChatOpened' then
      --       local body = vim.json.encode {
      --         model_name = request.match == 'CodeCompanionChatOpened' and 'lucyknada_Qwen_Qwen2.5-Coder-32B-Instruct-exl2'
      --           or 'lucyknada_Qwen_Qwen2.5-Coder-14B-Instruct-exl2',
      --         draft_model = {
      --           draft_model_name = 'lucyknada_Qwen_Qwen2.5-Coder-1.5B-Instruct-exl2',
      --         },
      --       }
      --       local curl = require 'plenary.curl'
      --       local async = require 'plenary.async'
      --       curl.post('http://localhost:5010/v1/model/load', {
      --         headers = {
      --           ['x-admin-key'] = 'e79fc6f6e89fe2072e20be5a91d57b67',
      --           ['Content-Type'] = 'application/json',
      --         },
      --         body = body,
      --         callback = function(data)
      --           async.util.scheduler(function()
      --             -- local body = vim.json.decode(data.body)
      --             -- for _, v in ipairs(body.data) do
      --             --   if v.id == opts.model then
      --             --     cb(true)
      --             --     return
      --             --   end
      --             -- end
      --             -- cb(false)
      --           end)
      --         end,
      --       })
      --     end
      --   end,
      -- })

      require("codecompanion").setup({
        opts = {
          system_prompt = function(opts)
            local language = opts.language or "English"
            return string.format(
              [[You are Qwen, created by Alibaba Cloud. You are a helpful assistant.
You are currently plugged in to the Neovim text editor on a user's machine.

Your core tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code in a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
- Use actual line breaks instead of '\n' in your response to begin new lines.
- Use '\n' only when you want a literal backslash followed by a character 'n'.
- All non-code responses must use %s.

When given a task:
1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
2. Output the code in a single code block, being careful to only return relevant code.
3. You should always generate short suggestions for the next user turns that are relevant to the conversation.
4. You can only give one reply for each conversation turn.]],
              language
            )
          end,
        },
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
          agent = {
            adapter = "tabby_api_32b",
            tools = {
              ["bag"] = {
                callback = "strategies.chat.tools.rag",
                description = "Supplement the LLM with real-time info from the internet",
                opts = {
                  hide_output = false,
                },
              },
            },
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

          ["tabby_api_7b"] = function()
            return require("codecompanion.adapters").extend("openai", {
              schema = {
                model = {
                  default = "lucyknada_Qwen_Qwen2.5-Coder-7B-Instruct-exl2",
                },
              },

              url = "http://media:5010/v1/chat/completions",
              env = {
                api_key = "TABBY_API_KEY",
              },
              headers = {
                ["Content-Type"] = "application/json",
              },
              parameters = {
                -- sync = true,
              },
            })
          end,

          ["tabby_api_14b"] = function()
            return require("codecompanion.adapters").extend("openai", {
              schema = {
                model = {
                  default = "lucyknada_Qwen_Qwen2.5-Coder-14B-Instruct-exl2",
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
              parameters = {
                -- sync = true,
              },
            })
          end,
          ["tabby_api_32b"] = function()
            return require("codecompanion.adapters").extend("openai", {
              schema = {
                model = {
                  default = "lucyknada_Qwen_Qwen2.5-Coder-32B-Instruct-exl2",
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
