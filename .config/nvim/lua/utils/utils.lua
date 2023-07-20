local M = {}

function M.bool2str(bool)
  return bool and 'on' or 'off'
end

function M.includes(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

return M
