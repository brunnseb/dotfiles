local function get_git_root()
  local dir = vim.fn.getcwd()
  local git_dir = vim.fn.finddir(".git", dir .. ";")
  if git_dir ~= "" then
    return vim.fn.fnamemodify(git_dir, ":h")
  end
  return nil
end

local handlers = {
  form_messages = function(self, messages)
    local system_content = {}
    local other_messages = {}
    -- 1. Separate system messages from everything else
    for _, msg in ipairs(messages) do
      if msg.role == "system" then
        table.insert(system_content, msg.content)
      else
        table.insert(other_messages, msg)
      end
    end
    local final_messages = {}
    -- 2. If there are system messages, merge them into ONE message at the top
    if #system_content > 0 then
      table.insert(final_messages, {
        role = "system",
        content = table.concat(system_content, "\n\n"),
      })
    end
    -- 3. Append all the user/assistant messages
    for _, msg in ipairs(other_messages) do
      table.insert(final_messages, msg)
    end
    -- 4. Pass the cleaned messages to the standard OpenAI handler
    local openai = require("codecompanion.adapters.http.openai")
    return openai.handlers.form_messages(self, final_messages)
  end,
  parse_message_meta = function(self, data)
    local extra = data.extra
    if extra and extra.reasoning_content then
      data.output.reasoning = { content = extra.reasoning_content }
      if data.output.content == "" then
        data.output.content = nil
      end
    end
    return data
  end,
}

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "ravitemer/codecompanion-history.nvim",
      "cairijun/codecompanion-agentskills.nvim",
      "cairijun/codecompanion-subagents.nvim",
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
      { "<leader>ar", "<cmd>CodeCompanionActions<cr>", desc = "Actions", mode = { "n", "x" } },
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "New Chat", mode = { "n", "x" } },
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = { "n", "x" } },
    },
    opts = function()
      return {
        mcp = {
          servers = {
            ["gitnexus"] = {
              cmd = { "gitnexus", "mcp" },
            },
            ["websearch"] = {
              cmd = { "npx", "-y", "mcp-searxng" },
              env = {
                SEARXNG_URL = "http://192.168.0.191:8888",
              },
            },
          },
        },
        interactions = {
          cmd = {
            adapter = {
              name = "fast",
            },
          },
          background = {
            adapter = {
              name = "default",
            },
          },
          chat = {
            adapter = {
              name = "default",
              model = "qwen3.6-35b",
            },
          },
          inline = {
            adapter = {
              name = "fast",
            },
          },
          cli = {
            agent = "opencode",
            agents = {
              opencode = {
                cmd = "opencode",
                description = "Opencode CLI",
                provider = "terminal",
              },
            },
          },
        },
        adapters = {
          acp = {
            opencode = function()
              return require("codecompanion.adapters").extend("opencode", {
                defaults = {
                  mcpServers = "inherit_from_config",
                },
              })
            end,
            opts = {
              show_presets = false,
            },
          },
          http = {
            default = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                schema = {
                  keep_alive = {
                    default = "5m",
                  },
                  model = {
                    default = "qwen3.6-35b",
                  },
                },
                env = {
                  chat_url = "/v1/chat/completions",
                  models_endpoint = "/v1/models",
                  url = "http://100.64.0.5:8080",
                },
                headers = {
                  ["Content-Type"] = "application/json",
                },
                parameters = {},
                handlers = handlers,
              })
            end,
            fast = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                schema = {
                  keep_alive = {
                    default = "5m",
                  },
                  model = {
                    default = "nemotron",
                  },
                },
                env = {
                  chat_url = "/v1/chat/completions",
                  models_endpoint = "/v1/models",
                  url = "http://100.64.0.5:8080",
                },
                headers = {
                  ["Content-Type"] = "application/json",
                },
                parameters = {},
                handlers = handlers,
              })
            end,
            opts = {
              show_model_choices = true,
              show_presets = false,
            },
          },
        },
        rules = {
          opts = {
            chat = {
              autoload = { "default", "cwd" },
            },
          },
          cwd = {
            description = "project files",
            files = {
              -- Specify dirs to search in (supports glob patterns and literals)
              {
                path = get_git_root(),
                files = { "AGENTS.md", "CLAUDE.md" },
              },
              "~/.claude/CLAUDE.md",
              "CLAUDE.md",
              "AGENTS.md",
            },
          },
        },
        extensions = {
          history = {
            enabled = true,
            opts = {
              keymap = "gh",
              save_chat_keymap = "sc",
              auto_save = true,
              expiration_days = 0,
              picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
              picker_keymaps = {
                rename = { n = "r", i = "<c-r>" },
                delete = { n = "d", i = "<c-d>" },
                duplicate = { n = "<C-y>", i = "<C-y>" },
              },
              auto_generate_title = true,
              title_generation_opts = {
                adapter = "fast", -- "copilot"
                model = "nemotron",
                refresh_every_n_prompts = 3, -- e.g., 3 to refresh after every 3rd user prompt
                max_refreshes = 10,
              },
              continue_last_chat = false,
              delete_on_clearing_chat = false,
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
              enable_logging = false,
              summary = {
                -- Keymap to generate summary for current chat (default: "gcs")
                create_summary_keymap = "gC",
                -- Keymap to browse summaries (default: "gbs")
                browse_summaries_keymap = "gbs",

                generation_opts = {
                  adapter = "fast",
                  model = "nemtoron", -- defaults to current chat adapter
                  context_size = 65536,
                  include_references = true, -- include slash command content
                  include_tool_outputs = true, -- include tool execution results
                },
              },
            },
          },
          agentskills = {
            opts = {
              paths = {
                { "~/.config/opencode", recursive = true },
              },
            },
          },
          subagents = {
            enabled = true,
            opts = {
              subagents = {
                generic = {
                  description = "A general-purpose subagent that you can delegate a task to. It sees all your previous messages so you don't need to repeat the whole context.",
                  tools = "inherit",
                  mcp_servers = "inherit",
                  context_mode = "inherit",
                  result_spec = "A brief summary of what you have done, or errors/exceptions encountered that prevented you from completing the task.",
                },
                code_reviewer = {
                  description = "Reviews code for bugs, style issues, and improvements",
                  system_prompt = "You are an expert code reviewer. Analyze code for potential issues, suggest improvements, and provide constructive feedback.",
                  tools = { "file_search", "get_changed_files", "grep_search", "read_file" },
                  context_spec = "1) Background information of the changes or repo. 2) The code files to review.",
                  result_spec = "A structured review with: issues found, severity, and suggestions",
                },
                web_researcher = {
                  description = [[Searches the web to answer specific questions.
Use this subagent when you need to research topics, find current information, or investigate technical issues online.
Returns a comprehensive report with citations.]],
                  system_prompt = [[You are a research specialist focused on web search and information synthesis.

Your workflow:
1. **Understand**: Peform a basic search to understand the question and gather background information.
2. **Plan**: Create a research plan outlining the key topics to investigate.
3. **Gather**: For each topic, perform targeted web searches to find relevant information, data, and sources.
4. **Synthesize**: Compile the research findings into a comprehensive report that directly answers the original question, including citations for all sources used.
]],
                  mcp_servers = { "brave-search" },
                  tools = { "fetch_webpage" },
                  context_spec = "The question or topic to research",
                  result_spec = [[A comprehensive research report that includes:
- A clear and concise answer to the research question
- Citations with links to sources (or file references for codebase research)
- Confidence levels for key claims (high/medium/low)
- Suggestions for further investigation if applicable]],
                },
                -- Use a cheaper/faster model for simple summarization tasks
                summarizer = {
                  description = "Summarizes text or documents concisely",
                  system_prompt = "You are a concise summarizer. Extract the key points and present them clearly.",
                  adapter = { name = "fast", model = "nemotron" },
                  context_spec = "The text or document to summarize",
                  result_spec = "A concise bullet-point summary of the key points",
                },
              },
            },
          },
        },
      }
    end,
  },
}
