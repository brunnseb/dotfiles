return {
  top_down = false,
  max_height = function() return math.floor(vim.o.lines * 0.3) end,
  max_width = function() return math.floor(vim.o.columns * 0.3) end,
}
