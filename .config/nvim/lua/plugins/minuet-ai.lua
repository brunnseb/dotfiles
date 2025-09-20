return {
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",
        n_completions = 5,
        context_window = 2048,
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name = "Llama.cpp",
            end_point = "http://ai:8080/v1/completions",
            model = "qwen3-30-coder",
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
            template = {
              prompt = function(context_before_cursor, context_after_cursor, _)
                return "" .. context_before_cursor .. "" .. context_after_cursor .. ""
              end,
              suffix = false,
            },
          },
        },
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            accept = "<A-A>",
            accept_line = "<A-a>",
            accept_n_lines = "<A-z>",
            prev = "<A-[>",
            next = "<C-l>",
            dismiss = "<A-e>",
          },
        },
      })
    end,
  },
}
