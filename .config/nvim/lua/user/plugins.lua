local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here

	-- Essentials
	use({ "lewis6991/impatient.nvim" })
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "nathom/filetype.nvim" })
	use({ "chaoren/vim-wordmotion", event = "BufRead" })
	use({ "andymass/vim-matchup", event = "CursorMoved" })
	use({
		"notjedi/nvim-rooter.lua",
		config = function()
			require("user.plugins._nvim-rooter").setup()
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
			})
		end,
	})
	use({ "stevearc/dressing.nvim" })

	-- Statusline
	use({
		"NTBBloodbath/galaxyline.nvim",
		-- your statusline
		config = function()
			require("galaxyline.themes.eviline")
		end,
		-- some optional icons
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Git
	use({
		"TimUntersberger/neogit",
		requires = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		config = function()
			require("user.plugins._neogit").setup()
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("user.plugins._gitsigns").setup()
		end,
	})
	use({
		"emmanueltouzery/agitator.nvim",
	})
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("git-conflict").setup()
		end,
	})

	-- Colorschemes
	use("shaunsingh/nord.nvim")
	use({
		"sam4llis/nvim-tundra",
		config = function()
			require("nvim-tundra").setup({
				transparent_background = false,
				editor = {
					search = {},
					substitute = {},
				},
				syntax = {
					booleans = { bold = true, italic = true },
					comments = { bold = true, italic = true },
					conditionals = {},
					constants = { bold = true },
					functions = {},
					keywords = {},
					loops = {},
					numbers = { bold = true },
					operators = { bold = true },
					punctuation = {},
					strings = {},
					types = { italic = true },
				},
				diagnostics = {
					errors = {},
					warnings = {},
					information = {},
					hints = {},
				},
				plugins = {
					lsp = true,
					treesitter = true,
					cmp = true,
					context = true,
					dbui = true,
					gitsigns = true,
					telescope = true,
				},
				overwrite = {
					colors = {},
					highlights = {},
				},
			})

			vim.opt.background = "dark"
			vim.cmd("colorscheme tundra")
		end,
	})
	-- Lsp
	use({
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufRead" },
		config = function()
			require("user.plugins._null-ls").setup()
		end,
	})
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})
	use("b0o/schemastore.nvim")
	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils",
	})
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use({ "mrshmllow/document-color.nvim" })
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")

			saga.init_lsp_saga({})
		end,
	})

	-- Telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("user.plugins._telescope").setup()
		end,
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim" },
		},
	})
	use({ "cljoly/telescope-repo.nvim" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"p00f/nvim-ts-rainbow",
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/playground",
		},
		config = function()
			require("user.plugins._treesitter").setup()
		end,
	})

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("user.plugins._cmp").setup()
		end,
	})

	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "nvim-cmp",
	})

	use({
		"tzachar/cmp-fuzzy-buffer",
		requires = { "tzachar/fuzzy.nvim" },
		after = "cmp-nvim-lsp",
	})
	use({ "hrsh7th/cmp-cmdline", after = "cmp-fuzzy-buffer" })
	use({
		"tzachar/cmp-fuzzy-path",
		requires = { "tzachar/fuzzy.nvim" },
		after = "cmp-cmdline",
	})
	use({ "hrsh7th/cmp-nvim-lua", after = "cmp-cmdline" })
	use({ "saadparwaiz1/cmp_luasnip", after = "cmp-nvim-lua" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" } })

	-- Which Key
	use({
		"folke/which-key.nvim",
		config = function()
			require("user.plugins._whichkey")
		end,
	})

	-- File Explorer
	use({
		"luukvbaal/nnn.nvim",
		config = function()
			require("nnn").setup()
		end,
	})

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("user.plugins._neotree").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
