return {
  {
    'yioneko/nvim-vtsls',
    ft = { 'typescriptreact', 'typescript', 'javascript', 'javascriptreact' },
    keys = {
      { '<leader>co', '<cmd>VtsExec organize_imports<CR>', desc = 'Organize imports' },
      { '<leader>ci', '<cmd>VtsExec add_missing_imports<CR>', desc = 'Add missing imports' },
      { '<leader>cu', '<cmd>VtsExec remove_unused<CR>', desc = 'Remove unused' },
      { '<leader>cR', '<cmd>VtsExec rename_file<CR>', desc = 'Rename file' },
      { '<leader>cs', '<cmd>VtsExec restart_tsserver<CR>', desc = 'Restart tsserver' },
    },
    config = function()
      require('vtsls').config {
        refactor_auto_rename = true,
        refactor_move_to_file = {
          telescope_opts = function(items, default) end,
        },
      }
    end,
  },
}
