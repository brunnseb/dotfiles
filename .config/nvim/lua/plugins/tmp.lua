return {
  { 'nacro90/numb.nvim', config = true },
  {
    'Wansmer/treesj',
    keys = {
      { 'J', '<cmd>TSJToggle<cr>', desc = 'Join Toggle' },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 120,
    },
  },
  {
    'monaqa/dial.nvim',
    -- stylua: ignore
    keys = {
      {
        "]a",
        function() return require("dial.map").inc_normal() end,
        expr = true,
        desc = "Increment",
      },
      {
        "[a",
        function() return require("dial.map").dec_normal() end,
        expr = true,
        desc = "Decrement",
      },
    },
    config = function()
      local augend = require 'dial.augend'
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new { elements = { 'let', 'const' } },
        },
      }
    end,
  },
  {
    'echasnovski/mini.bracketed',
    event = 'BufReadPost',
    config = function()
      local bracketed = require 'mini.bracketed'

      -- local function put(cmd, regtype)
      --   local body = vim.fn.getreg(vim.v.register)
      --   local type = vim.fn.getregtype(vim.v.register)
      --   ---@diagnostic disable-next-line: param-type-mismatch
      --   vim.fn.setreg(vim.v.register, body, regtype or "l")
      --   bracketed.register_put_region()
      --   vim.cmd(('normal! "%s%s'):format(vim.v.register, cmd:lower()))
      --   ---@diagnostic disable-next-line: param-type-mismatch
      --   vim.fn.setreg(vim.v.register, body, type)
      -- end
      --
      -- for _, cmd in ipairs({ "]p", "[p" }) do
      --   vim.keymap.set("n", cmd, function()
      --     put(cmd)
      --   end)
      -- end
      -- for _, cmd in ipairs({ "]P", "[P" }) do
      --   vim.keymap.set("n", cmd, function()
      --     put(cmd, "c")
      --   end)
      -- end
      --
      -- local put_keys = { "p", "P" }
      -- for _, lhs in ipairs(put_keys) do
      --   vim.keymap.set({ "n", "x" }, lhs, function()
      --     return bracketed.register_put_region(lhs)
      --   end, { expr = true })
      -- end

      bracketed.setup {
        file = { suffix = '' },
        window = { suffix = '' },
        quickfix = { suffix = '' },
        yank = { suffix = '' },
        treesitter = { suffix = 'n' },
      }
    end,
  },
  {
    'danymat/neogen',
    keys = {
      {
        '<leader>mc',
        function()
          require('neogen').generate {}
        end,
        desc = 'Neogen Comment',
      },
    },
    opts = { snippet_engine = 'luasnip' },
  },
}
