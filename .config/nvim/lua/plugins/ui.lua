return {
  {
    'echasnovski/mini.animate',
    recommended = true,
    event = 'VeryLazy',
    opts = function()
      local animate = require 'mini.animate'
      return {
        resize = {
          timing = animate.gen_timing.linear { duration = 50, unit = 'total' },
        },
      }
    end,
  },
}
