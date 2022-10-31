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

	-- Colorscheme creation
	use({ "rktjmp/lush.nvim" })
	use({ "uga-rosa/ccc.nvim" })

	-- Essentials
	use({ "lewis6991/impatient.nvim" })
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "nathom/filetype.nvim" })
	use({ "chaoren/vim-wordmotion", event = "BufRead" })
	use({ "andymass/vim-matchup", event = "CursorMoved" })
	use({ "jinh0/eyeliner.nvim" })
	use({
		"axelvc/template-string.nvim",
		config = function()
			require("template-string").setup({})
		end,
	})
	use({

		"kkoomen/vim-doge",
		run = ":call doge#install()",
	})
	use({
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})
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
		config = function()
			require("nvim-surround").setup({})
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
	use({ "mg979/vim-visual-multi" })
	use({
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	})
	use({
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup({
				close_fold_kinds = {},
			})
		end,
	})

	-- Statusline
	use({
		"windwp/windline.nvim",
		config = function()
			require("wlsample.bubble2")
		end,
	})

	-- Git
	use({ "kdheepak/lazygit.nvim" })
	use({ "sindrets/diffview.nvim" })
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
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			local util = require("catppuccin.utils.colors")

			require("catppuccin").setup({

				flavour = "macchiato", -- mocha, macchiato, frappe, latte
				highlight_overrides = {
					macchiato = function(macchiato)
						return {
							-- Treesitter
							["@boolean"] = { fg = macchiato.pink },
							["@constant"] = { fg = macchiato.red },
							["@constant.builtin"] = { fg = macchiato.yellow },
							["@constant.macro"] = { fg = macchiato.mauve },
							["@constructor"] = { fg = macchiato.teal },
							["@danger"] = { fg = macchiato.base, bg = macchiato.red },
							["@field"] = { fg = macchiato.text },
							["@field.lua"] = { fg = macchiato.text },
							["@float"] = { fg = macchiato.pink },
							["@function"] = { fg = macchiato.sky },
							["@function.builtin"] = { fg = macchiato.yellow },
							["@function.macro"] = { fg = macchiato.teal },
							["@include"] = { fg = macchiato.yellow },
							["@keyword"] = { fg = macchiato.yellow },
							["@keyword.function"] = { fg = macchiato.mauve },
							["@keyword.operator"] = { fg = macchiato.peach },
							["@keyword.return"] = { fg = macchiato.pink },
							["@label"] = { fg = macchiato.sapphire },
							["@method"] = { fg = macchiato.text },
							["@namespace"] = { fg = macchiato.blue },
							["@note"] = { fg = macchiato.base, bg = macchiato.blue },
							["@number"] = { fg = macchiato.pink },
							["@operator"] = { fg = macchiato.green },
							["@parameter"] = { fg = macchiato.sky },
							["@property"] = { fg = macchiato.flamingo },
							["@punctuation.bracket"] = { fg = macchiato.text },
							["@punctuation.special"] = { fg = macchiato.sky },
							["@string"] = { fg = macchiato.green },
							["@string.escape"] = { fg = macchiato.pink },
							["@string.regex"] = { fg = macchiato.peach },
							["@tag"] = { fg = macchiato.teal },
							["@tag.attribute"] = { fg = macchiato.yellow },
							["@tag.delimiter"] = { fg = macchiato.pink },
							["@text"] = { fg = macchiato.text },
							["@text.emphasis"] = { fg = macchiato.maroon },
							["@text.literal"] = { fg = macchiato.teal },
							["@text.reference"] = { fg = macchiato.lavender },
							["@text.strong"] = { fg = macchiato.maroon },
							["@text.title"] = { fg = macchiato.blue },
							["@text.uri"] = { fg = macchiato.rosewater },
							["@type"] = { fg = macchiato.peach },
							["@type.builtin"] = { fg = macchiato.yellow },
							["@variable"] = { fg = macchiato.text },
							["@variable.builtin"] = { fg = macchiato.red },
							["@warning"] = { fg = macchiato.base, bg = macchiato.yellow },
							-- TSX
							["@constructor.tsx"] = { fg = macchiato.teal },
							["@tag.tsx"] = { fg = macchiato.teal },
							["@tag.attribute.tsx"] = { fg = macchiato.yellow, style = { "italic" } },
							["@tag.delimiter.tsx"] = { fg = macchiato.pink },
							-- TS
							["@constructor.ts"] = { fg = macchiato.teal },
							-- JSON
							["@label.json"] = { fg = macchiato.yellow },
							-- Core
							Comment = { fg = macchiato.blue },
							Cursor = { fg = macchiato.text, bg = macchiato.pink }, -- character under the cursor
							CursorLine = { bg = util.lighten(macchiato.base, 0.8) },
							Visual = { bg = cp.sapphire, fg = macchiato.crust, style = { "bold" } },
							LineNr = { fg = macchiato.fg },
							Pmenu = { bg = cp.mantle, fg = cp.text },
							PmenuSel = { fg = cp.text, bg = cp.pink, style = { "bold" } },
							Search = {
								bg = util.darken(cp.yellow, 0.5),
								fg = cp.text,
								style = { "bold" },
							}, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand oucp.
						}
					end,
				},
				color_overrides = {
					macchiato = {
						rosewater = "#dc8a78",
						flamingo = "#DD7878",
						pink = "#FF6CA4",
						mauve = "#7F6ABE",
						red = "#D45A7E",
						maroon = "#E64553",
						peach = "#FF9D03",
						yellow = "#FFD701",
						green = "#97EA88",
						teal = "#00C8A0",
						sky = "#90EBED",
						sapphire = "#84DCC6",
						blue = "#0088FF",
						lavender = "#006dcc",
						text = "#E2EFFE",
						subtext1 = "#5B6268",
						subtext0 = "#DFDFDF",
						overlay0 = "#7C7F93",
						overlay1 = "#8C8FA1",
						overlay2 = "#9CA0B0",
						surface0 = "#ACB0BE",
						surface1 = "#BCC0CC",
						surface2 = "#CCD0DA",

						crust = "#1B2229",
						mantle = "#1A3549",
						base = "#21425b",
					},
				},
				styles = {
					keywords = { "italic" },
					booleans = { "italic" },
				},
			})
			vim.api.nvim_command("colorscheme catppuccin")
		end,
	})
	-- use({
	-- 	-- "brunnseb/catppuccin",
	-- 	"~/Development/catppuccin",
	-- 	as = "catppuccin",
	-- 	config = function()
	-- 		vim.g.catppuccin_flavour = "mocha"
	-- 		require("catppuccin").setup()
	-- 		vim.cmd([[colorscheme catppuccin]])
	-- 	end,
	-- })
	-- Lsp
	use({
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufRead" },
		commit = "cdef04dfad2d1a6d76f596ac63600e7430baaabe",
		config = function()
			require("user.plugins._null-ls").setup()
		end,
	})
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("user.plugins._fidget").setup()
		end,
	})
	use("b0o/schemastore.nvim")
	use({
		"jose-elias-alvarez/typescript.nvim",
		config = function()
			require("user.plugins._typescript").setup()
		end,
	})
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	-- Colorize
	use({ "mrshmllow/document-color.nvim" })
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
				-- An example
				"!css",
				"!html",
				"!tsx",
				"!dart",
			})
		end,
	})
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})
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

	use({ "gaelph/logsitter.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })

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
