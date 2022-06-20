local M = {}

function M.setup()
	require("fm-nvim").setup({
		ui = {
			float = {
				border = "single",
			},
		},
		cmds = {
			nnn_cmd = "nnn",
			fzf_cmd = "fzf", -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
			gitui_cmd = "gitui",
			ranger_cmd = "ranger",
			lazygit_cmd = "lazygit",
		},
	})
end

return M
