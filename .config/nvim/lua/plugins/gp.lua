return {
  {
    "robitx/gp.nvim",
    cmd = { "GpChatNew", "GpChatToggle", "GpImplement", "GpDocument" },
    keys = {
      {
        "<leader>ad",
        ":<C-u>'<,'>GpDocument<CR>",
        mode = "v",
        desc = "Write docstring",
      },
      {
        "<leader>at",
        ":<C-u>'<,'>GpEnew write tests using vitest and react testing library while importing all needed functions from vitest<CR>",
        mode = "v",
        desc = "Write tests into new file",
      },
      {
        "<leader>ai",
        ":<C-u>'<,'>GpImplement<CR>",
        mode = "v",
        desc = "Implement",
      },
      {
        "<leader>at",
        "<cmd>GpChatToggle<CR>",
        desc = "Toggle Chat",
      },
      {
        "<leader>aq",
        "<cmd>GpChatDelete<CR>",
        desc = "Delete Chat",
      },
      {
        "<leader>an",
        "<cmd>GpChatNew<CR>",
        desc = "New Chat",
      },
    },
    config = function()
      require("gp").setup({
        hooks = {
          Implement = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please rewrite this according to the contained instructions."
              .. "\n\nRespond exclusively with the snippet that should replace the selection above."

            local agent = gp.get_command_agent()

            gp.Prompt(
              params,
              gp.Target.append,
              nil, -- command will run directly without any prompting for user input
              agent.model,
              template,
              agent.system_prompt
            )
          end,
          -- GpImplement rewrites the provided selection/range based on comments in it
          Document = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Write really good documentation using best practices for the given language. Infer all possible properties from the used interface, ignore all properties inherited from standard html elements and do not document types for typescript files"
              .. "\n\nOnly return the docstring and nothing else."

            local agent = gp.get_command_agent()

            gp.Prompt(
              params,
              gp.Target.prepend,
              nil, -- command will run directly without any prompting for user input
              agent.model,
              template,
              agent.system_prompt
            )
          end,
        },
      })

      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)

      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
  },
}
