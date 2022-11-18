local M = {}

function M.setup()
	local status_ok, rooter = pcall(require, "nvim-rooter")
	if not status_ok then
		return
	end
  rooter.setup({
    rooter_patterns = { ".git", "_darcs", ".bzr", ".svn", "Makefile", "README.md" },
    trigger_patterns = { "*" },
    manual = false,
  })
end

return M
