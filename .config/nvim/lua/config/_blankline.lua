local M = {}

function M.setup()
	local blankline = require("indent_blankline")

	blankline.setup({
		indentLine_enabled = 1,
		char = "▏",
		space_char_blankline = " ",
		buftype_exclude = { "terminal" },
		filetype_exclude = { "help", "terminal", "dashboard", "packer", "alpha" },
		show_current_context = true,
	})
end

return M
