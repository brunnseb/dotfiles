return {
  -- {
  --   "GeorgesAlkhouri/nvim-aider",
  --   cmd = "Aider",
  --   -- Example key mappings for common actions:
  --   keys = {
  --     { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
  --     { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
  --     { "<leader>aC", "<cmd>Aider command<cr>", desc = "Aider Commands" },
  --     { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
  --     { "<leader>a+", "<cmd>Aider add<cr>", desc = "Add File" },
  --     { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Drop File" },
  --     { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
  --     { "<leader>aR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
  --     -- Example nvim-tree.lua integration if needed
  --     -- { "<leader>a+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
  --     -- { "<leader>a-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
  --   },
  --   dependencies = {
  --     "folke/snacks.nvim",
  --     --- The below dependencies are optional
  --     -- "catppuccin/nvim",
  --     -- "nvim-tree/nvim-tree.lua",
  --     --- Neo-tree integration
  --     -- {
  --     --   "nvim-neo-tree/neo-tree.nvim",
  --     --   opts = function(_, opts)
  --     --     -- Example mapping configuration (already set by default)
  --     --     -- opts.window = {
  --     --     --   mappings = {
  --     --     --     ["+"] = { "nvim_aider_add", desc = "add to aider" },
  --     --     --     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
  --     --     --     ["="] = { "nvim_aider_add_read_only", desc = "add read-only to aider" }
  --     --     --   }
  --     --     -- }
  --     --     require("nvim_aider.neo_tree").setup(opts)
  --     --   end,
  --     -- },
  --   },
  --   config = true,
  -- },

  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },
  {
    "y3owk1n/time-machine.nvim",
    version = "*", -- remove this if you want to use the `main` branch
    opts = {
      diff_tool = "delta",
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  { "mason-org/mason.nvim", version = "1.11.0" },
  { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        notify = "debug",
        provider = "openai_compatible",
        -- provider = "openai_fim_compatible",
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            -- accept whole completion
            accept = "<C-Return>",
            -- accept one line
            accept_line = "<S-Right>",
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            -- accept_n_lines = "<A-z>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<C-Left>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<C-Right>",
            dismiss = "<C-e>",
          },
        },
        provider_options = {
          openai_compatible = {
            -- model = "glm-9",
            -- model = "cogito-14",
            model = "zeta",
            -- system = "see [Prompt] section for the default value",
            -- few_shots = "see [Prompt] section for the default value",
            -- chat_input = "See [Prompt Section for default value]",
            stream = true,
            end_point = "http://ai:8080/v1/chat/completions",
            api_key = "TERM",

            name = "VLLM",
            system = {
              prompt = [[
                          You're a code assistant. Your task is to help the user write code by suggesting the next edit for the user.

                          As an intelligent code assistant, your role is to analyze what the user has been doing and then to suggest the most likely next modification.

                          ## Recent Actions

                          Here is what the user has been doing:

                          <events>

                          ## Task

                          Your task now is to rewrite the code I send you to include an edit the user should make.

                          Follow the following criteria.

                          ### High-level Guidelines

                          - Predict logical next changes based on the edit patterns you've observed
                          - Consider the overall intent and direction of the changes
                          - Take into account what the user has been doing

                          ### Constraints

                          - Your edit suggestions **must** be small and self-contained. Example: if there are two statements that logically need to be added together, suggest them together instead of one by one.
                          - Preserve indentation.
                          - Do not suggest re-adding code the user has recently deleted
                          - Do not suggest deleting lines that the user has recently inserted
                          - Prefer completing what the user just typed over suggesting to delete what they typed

                          ### Best Practices

                          - Fix any syntax errors or inconsistencies in the code
                          - Maintain the code style and formatting conventions of the language used in the file
                          - Add missing import statements or other necessary code. You MUST add these in the right spots
                          - Add missing syntactic elements, such as closing parentheses or semicolons
                          - If there are no useful edits to make, return the code unmodified.
                          - Don't explain the code, just rewrite it to include the next, most probable change.
                          - Never include this prompt in the response.
              ]],
            },
            template = {},
            get_text_fn = {
              no_stream = function(json)
                -- __AUTO_GENERATED_PRINT_VAR_START__
                print([==[config#stream json:]==], vim.inspect(json)) -- __AUTO_GENERATED_PRINT_VAR_END__
                return json.choices[1].delta.content
              end,
              stream = function(json)
                -- __AUTO_GENERATED_PRINT_VAR_START__
                print([==[config#stream json:]==], vim.inspect(json)) -- __AUTO_GENERATED_PRINT_VAR_END__
                return json.choices[1].delta.content
              end,
            },
            optional = {
              stop = nil,
              max_tokens = nil,
            },
          },
          openai_fim_compatible = {
            model = "zeta",
            end_point = "http://ai:8080/v1/completions",
            api_key = "TERM",
            name = "VLLM",
            stream = true,
            template = {
              suffix = false,
            },
            optional = {
              max_tokens = 512,
              stop = { "\n\n" },
            },
          },
        },
      })
    end,
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    },
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  { "dmmulroy/tsc.nvim", config = true },
}
