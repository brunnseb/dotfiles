return {
  {
    "LintaoAmons/cd-project.nvim",
    keys = {
      { "<leader>pa", "<cmd>CdProjectAdd<CR>", desc = "[A]dd Project" },
      { "<leader>pp", "<cmd>CdProject<CR>", desc = "List [P]rojects" },
      {
        "<leader>pd",
        function()
          local api = require("cd-project.api")
          local bundles = api.get_project_names()
          vim.ui.select(bundles, {
            prompt = "Select project to delete",
          }, function(name)
            ---@diagnostic disable-next-line: missing-fields
            api.delete_project({ name = name })
          end)
        end,
        desc = "[D]elete project",
      },
    },
    config = function()
      require("cd-project").setup({
        projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/cd-project.nvim.json"),
        project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
        choice_format = "both", -- optional, you can switch to "name" or "path"
        hooks = {
          {
            callback = function(dir)
              vim.notify("switched to dir: " .. dir)
            end,
          },
        },
      })
    end,
  },
}
