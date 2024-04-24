return {
  {
    'LintaoAmons/cd-project.nvim',
    keys = {
      { '<leader>pa', '<cmd>CdProjectAdd<CR>', desc = '[A]dd Project' },
      { '<leader>pp', '<cmd>CdProject<CR>', desc = 'List [P]rojects' },
    },
    config = function()
      require('cd-project').setup {
        projects_config_filepath = vim.fs.normalize(vim.fn.stdpath 'config' .. '/cd-project.nvim.json'),
        project_dir_pattern = { '.git', '.gitignore', 'Cargo.toml', 'package.json', 'go.mod' },
        choice_format = 'both', -- optional, you can switch to "name" or "path"
        hooks = {
          {
            callback = function(dir)
              vim.notify('switched to dir: ' .. dir)
            end,
          },
        },
      }
    end,
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {},
  },
}
