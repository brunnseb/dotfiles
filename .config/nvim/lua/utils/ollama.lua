local curl = require 'plenary.curl'

local M = {}

M.loadModel = function(model_name)
  curl.request {
    url = 'http://media:7869/api/generate',
    method = 'POST',
    body = {
      model = model_name,
    },
  }
end

return M
