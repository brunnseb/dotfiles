return {
  {
    'nvim-neotest/neotest',
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-vitest',
        },
      }
    end,
    dependencies = {
      'marilari88/neotest-vitest',
    },
  },
}
