local M = {}

M.setup = function(opts)
  return {
    result_padding = "⏐  ",
    mapping = vim.tbl_deep_extend("force", opts.mapping, {
      ["send_to_qf"] = {
        map = "Q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix",
      },
    }),
  }
end

return M
