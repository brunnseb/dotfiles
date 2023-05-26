-- Autocmds
vim.api.nvim_create_autocmd("WinLeave", {
  desc = "Prevent opening files from telescope in insert mode",
  -- group = vim.api.nvim_create_augroup("autocomp", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})
