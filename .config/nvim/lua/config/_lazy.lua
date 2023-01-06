local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- load lazy
require("lazy").setup("plugins", {
	install = { colorscheme = { "catppuccin" } },
	defaults = { lazy = true },
	checker = { enabled = true },
	performance = {
		cache = { enabled = true },
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	debug = false,
	ui = {
		size = { width = 0.8, height = 0.8 },
		border = "rounded",
		icons = {
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
})
