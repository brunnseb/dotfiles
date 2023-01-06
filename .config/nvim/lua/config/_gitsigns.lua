local M = {}

function M.setup()
	local status_ok, gitsigns = pcall(require, "gitsigns")

	if not status_ok then
		return
	end

	gitsigns.setup({
		current_line_blame = true,
		yadm = {
			enable = true,
		},
	})
end

return M
