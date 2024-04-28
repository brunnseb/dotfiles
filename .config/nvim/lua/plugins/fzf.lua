return {
  {
    'ibhagwan/fzf-lua',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local fzf = require 'fzf-lua'
      fzf.setup { 'telescope', winopts = {
        preview = {
          layout = 'flex',
        },
      } }

      fzf.register_ui_select(function(_, items)
        local min_h, max_h = 0.15, 0.70
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return { winopts = { height = h, width = 0.60, row = 0.40 } }
      end)

      vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', fzf.live_grep_glob, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', fzf.diagnostics_workspace, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<CR>', { desc = '[S]earch [U]ndotree' })
      vim.keymap.set('n', '<leader><leader>', function()
        fzf.buffers()
      end, { desc = '[ ] Find existing buffers' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        fzf.files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
