vim.cmd [[
try
  colorscheme tundra
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
