local cmp = require "cmp"

return {
  mapping = {
    ["<S-CR>"] = cmp.mapping.confirm { select = true },
  },
}
