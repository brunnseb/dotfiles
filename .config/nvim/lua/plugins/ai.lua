return {
  {
    -- 'huynle/ogpt.nvim',
    dir = '/home/brunnseb/Development/ogpt.nvim/',
    keys = {
      {
        '<leader>an',
        function()
          -- Hack until https://github.com/MunifTanjim/nui.nvim/pull/367 gets resolved
          require('lazy').reload { plugins = { 'ogpt.nvim' } }
          vim.cmd [[OGPT]]
        end,
        desc = 'New chat',
      },
    },
    opts = {
      default_provider = 'ollama',
      edgy = true, -- enable this!
      single_window = false, -- set this to true if you want only one OGPT window to appear at a time
      providers = {
        ollama = {
          api_host = 'http://media:7869',
          model = 'codeqwen:7b-chat-v1.5-q4_1',
          api_chat_params = {
            temperature = 1.2,
            top_p = 0.9,
          },
        },
      },
      -- chat = { system = 'Use the pattern ```{filetype}{code}``` for nested code snippets' },
      chat = { system = 'Always answer with I do not know!' },
      actions = {

        doc = {
          -- type = "popup", -- could be a string or table to override
          type = 'completions',
          -- strategy = 'prepend',
          -- provider = 'ollama', -- default to "default_provider" if not provided
          -- model = 'llama3:8b-instruct-q4_K_M', -- default to "provider.<default_provider>.model" if not provided
          template = 'Write a concise docstring using the {{{filetype}}} programming language:\n\n```{{{input}}}```',
          system = 'You are a helpful senior software engineer, given a code snippet please write a concise and short docstring using best practices in the given programming language. Return ONLY the docstring.',
          params = {
            temperature = 0.3,
          },
        },
      },
    },
    config = function(_, opts)
      vim.treesitter.language.register('markdown', 'ogpt-window')

      require('ogpt').setup(opts)
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'robitx/gp.nvim',
    cmd = { 'GpChatNew', 'GpChatToggle', 'GpImplement', 'GpDocument', 'GpCodeReview' },
    keys = {
      {
        '<leader>ad',
        ":<C-u>'<,'>GpDocument<CR>",
        mode = 'v',
        desc = 'Write docstring',
      },
      {
        '<leader>at',
        ":<C-u>'<,'>GpEnew write tests using vitest and react testing library while importing all needed functions from vitest<CR>",
        mode = 'v',
        desc = 'Write tests into new file',
      },
      {
        '<leader>ai',
        ":<C-u>'<,'>GpImplement<CR>",
        mode = 'v',
        desc = 'Implement',
      },
      {
        '<leader>as',
        '<cmd>GpStop<CR>',
        desc = 'Stop output',
      },
    },
    config = function()
      require('gp').setup {
        openai_api_endpoint = 'http://media:7869/v1/chat/completions',
        openai_api_key = 'dummy',
        -- model = {
        --   -- model = 'mistral:7b-instruct-v0.2-q4_K_M',
        --   model = 'llama3:8b-instruct-q4_K_M',
        --   num_ctx = 8192,
        -- },
        chat_topic_gen_model = 'codeqwen:7b-chat-v1.5-q4_1',
        system_prompt = 'You are a general AI assistant.',
        hooks = {
          CodeReview = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please analyze for code smells and suggest improvements.'
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.enew 'markdown', nil, 'codeqwen:7b-chat-v1.5-q4_1', template, agent.system_prompt)
          end,
          -- GpImplement rewrites the provided selection/range based on comments in it
          Document = function(gp, params)
            local template = 'In the file {{filename}} with type {{filetype}} we have the following code:\n\n'
              .. '{{selection}}\n\n'
              .. 'Please write a correct, concise yet short docstring using best practices for the given language.\n'
              .. 'ONLY return the docstring, no other code or explanations and also do not include the provided code snippet in the response'
              .. 'Take the following example:\n'
              .. 'const Component: FC = ()=> <div>Component</div>\n'
              .. 'This should result in: \n'
              .. '/*\n'
              .. '* A component which returns a div with the text Component\n'
              .. '*/\n'
              .. 'and not:\n'
              .. '/*\n'
              .. '* A component which returns a div with the text Component\n'
              .. '*/\n'
              .. 'const Component: FC = ()=> <div>// code here</div>\n'

            gp.Prompt(
              params,
              gp.Target.prepend,
              nil, -- command will run directly without any prompting for user input
              { model = 'codeqwen:7b-chat-v1.5-q4_1', temperature = 1.2, top = 0.99 },
              template,
              'You are an AI working as a code editor providing answers.\n\n'
                .. 'Use 4 SPACES FOR INDENTATION.\n'
                .. 'Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n'
                .. 'START AND END YOUR ANSWER WITH:\n\n'
            )
          end,
        },
      }

      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)

      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
  },
}
