return {
  {
    'ray-x/sad.nvim',
    dependencies = { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
    config = function()
      require('sad').setup {}

      local escape_string
      do
        local matches = {
          [' '] = '[[:space:]]',
          ['^'] = '\\^',
          ['$'] = '\\$',
          ['('] = '\\(',
          [')'] = '\\)',
          ['%'] = '\\%',
          ['.'] = '\\.',
          ['['] = '\\[',
          [']'] = '\\]',
          ['{'] = '\\{',
          ['}'] = '\\}',
          ['*'] = '\\*',
          ['+'] = '\\+',
          ['-'] = '\\-',
          ['?'] = '\\?',
          ['='] = '\\=',
          ["'"] = "\\'",
          ['"'] = '\\"',
        }

        escape_string = function(s)
          return (s:gsub('.', matches))
        end
      end

      local get_selected_text = function()
        -- Exit visual mode, otherwise will return postion of the last visual selection
        local ESC_FEEDKEY = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(ESC_FEEDKEY, 'n', true)
        vim.api.nvim_feedkeys('gv', 'x', false)
        vim.api.nvim_feedkeys(ESC_FEEDKEY, 'n', true)

        local _, start_row, start_col, _ = unpack(vim.fn.getpos "'<")
        local _, end_row, end_col, _ = unpack(vim.fn.getpos "'>")
        start_row = start_row - 1
        end_row = end_row - 1

        local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
        if #lines == 1 then
          lines[1] = escape_string(string.sub(lines[1], start_col, end_col))
        else
          lines[1] = escape_string(string.sub(lines[1], start_col))
          lines[#lines] = escape_string((string.sub(lines[#lines], 1, end_col)))
        end

        return '(' .. table.concat(lines, '\\n') .. ')'
      end

      vim.keymap.set({ 'x' }, '<leader>sx', function()
        local old = get_selected_text()
        vim.ui.input({ prompt = 'Replace with:', default = '' }, function(tag)
          if tag then
            require('sad').Replace(old, tag)
          end
        end)
      end, { desc = 'Replace selection' })
    end,
  },
}
