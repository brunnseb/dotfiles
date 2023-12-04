local M = {}

function M.toggle()
  if vim.g.colors_name == 'tokyonight' then
    vim.cmd [[colorscheme catppuccin-macchiato]]
  else
    vim.cmd [[colorscheme tokyonight]]
  end
end

return M
