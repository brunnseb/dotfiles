-- Autocmds
-- vim.api.nvim_create_autocmd("WinLeave", {
--   desc = "Prevent opening files from telescope in insert mode",
--   -- group = vim.api.nvim_create_augroup("autocomp", { clear = true }),
--   pattern = "*",
--   callback = function()
--     if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
--       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
--     end
--   end,
-- })
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "qf", "lspinfo", "neotest-output", "neotest-output-panel", "spectre_panel" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})

local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true })
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { group = hocon_group, pattern = "*/*.conf", command = "set ft=hocon" }
)

