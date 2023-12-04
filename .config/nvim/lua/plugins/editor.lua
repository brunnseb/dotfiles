local function is_gp_buffer(buf_nr)
  local content = vim.api.nvim_buf_get_lines(buf_nr, 0, 1, false)
  return string.sub(table.concat(content, "\n"), 0, 8) == "# topic:"
end

return {
  {
    "luukvbaal/nnn.nvim",
    opts = {
    },
    keys = {
      { "<leader>fn", "<cmd>NnnExplorer %:p:h<CR>", desc = "Nnn Picker" },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      { "S", mode = { "x", "o" }, false },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        custom_filter = function(buf_number)
          return is_gp_buffer(buf_number) ~= true
        end,
      },
    },
  },
  {
    "robitx/gp.nvim",
    cmd = { "GpChatNew", "GpChatToggle" },
    keys = {
      {
        "<leader>ad",
        ":<C-u>'<,'>GpPrepend write docstring<CR>",
        mode = "v",
        desc = "Write docstring",
      },
      {
        "<leader>at",
        ":<C-u>'<,'>GpEnew write tests using vitest and react testing library<CR>",
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
          -- GpImplement rewrites the provided selection/range based on comments in it
          Implement = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please rewrite this according to the contained instructions."
                .. "\n\nRespond exclusively with the snippet that should replace the selection above."

            local agent = gp.get_command_agent()
            -- gp.Info("Implementing selection with agent: " .. agent.name)

            gp.Prompt(
              params,
              gp.Target.append,
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
  {
    "uga-rosa/translate.nvim",
    cmd = { "Translate" },
    opts = {
      default = {
        output = "replace",
        parse_before = "concat,trim,natural",
      },
    },
  },
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.left = opts.left or {}
      table.insert(opts.left, {
        ft = "nnn",
      })

      opts.right = {
        { ft = 'Fm' },
        {
          ft = "markdown",
          -- pinned = true,
          title = "ChatGPT",
          size = { width = 0.25 },
          filter = function(buf)
            return is_gp_buffer(buf)
          end,
          -- open = "GpChatToggle",
        },
        { ft = 'Outline', pinned = true, open = 'Outline' }
      }
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
    },
  },
  {
    'silvercircle/outline.nvim',
    cmd = { 'Outline' },
    keys = {
      { '<leader>co', '<cmd>OutlineFocus<CR>', "Outline Focus" },
      { '<leader>cO', '<cmd>Outline<CR>',      "Outline" }
    },
    config = true
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'marilari88/neotest-vitest',
    },
    opts = {
      adapters = {
        'neotest-vitest'
      }
    }
  },
  { 'metakirby5/codi.vim' }
  -- { 'RaafatTurki/corn.nvim', config = true }
}