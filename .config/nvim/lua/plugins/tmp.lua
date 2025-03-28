return {
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",
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
          openai_fim_compatible = {
            model = "LLMJapan_OlympicCoder-7B_exl2_8.0bpw",
            end_point = "http://ai:5011/v1/completions",
            api_key = "TABBY_API_KEY",
            name = "VLLM",
            stream = true,
            template = {
              prompt = function(pref, suff)
                local prompt_message = ""
                -- local cache_result = vectorcode_cacher.query_from_cache(0)
                -- for _, file in ipairs(cache_result) do
                --   prompt_message = prompt_message .. "<|file_sep|>" .. file.path .. "\n" .. file.document
                -- end
                return prompt_message .. "<|fim_prefix|>" .. pref .. "<|fim_suffix|>" .. suff .. "<|fim_middle|>"
              end,
              suffix = false,
            },
            optional = {
              max_tokens = 256,
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
