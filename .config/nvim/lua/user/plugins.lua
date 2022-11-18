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
	use({
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup()
		end,
	})
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

	-- Neorg
	use({
		"nvim-neorg/neorg",
		run = ":Neorg sync-parsers",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.norg.dirman"] = {
						config = {
							workspaces = {
								work = "~/Documents/neorg/work",
								personal = "~/Documents/neorg/personal",
								gtd = "~/Documents/neorg/gtd",
							},
						},
					},
					["core.gtd.base"] = {
						config = {
							workspace = "gtd",
						},
					}, -- ["core.norg.completion"] = {
					-- 	config = { -- Note that this table is optional and doesn't need to be provided
					-- 		engine = "nvim-cmp",
					-- 	},
					-- },
					["core.norg.concealer"] = {},
					["core.export"] = {},

					["core.integrations.telescope"] = {}, -- Enable the telescope module
				},
			})
		end,
		requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
	})

	-- Statusline
	use({
		"akinsho/bufferline.nvim",
		after = "catppuccin",
		config = function()
			require("user.plugins._bufferline").setup()
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("user.plugins._lualine").setup()
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

	use({ "michaeldyrynda/carbon" })
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
							Comment = { fg = macchiato.blue, style = { "italic" } },
							Cursor = { fg = macchiato.text, bg = macchiato.pink }, -- character under the cursor
							CursorLine = { bg = util.darken(macchiato.base, 0.8) },
							Visual = { bg = macchiato.sapphire, fg = macchiato.crust, style = { "bold" } },
							LineNr = { fg = macchiato.overlay0 },
							Pmenu = { bg = macchiato.mantle, fg = macchiato.text },
							PmenuSel = { fg = macchiato.text, bg = macchiato.pink, style = { "bold" } },
							Search = {
								bg = util.darken(macchiato.yellow, 0.5),
								fg = macchiato.text,
								style = { "bold" },
							}, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand oucp.
							VertSplit = { fg = macchiato.teal },
							-- BufferLine
							-- BufferLineFill = { bg = util.darken(macchiato.base, 0.8) },
							-- BufferLineBufferSelected = {
							-- 	bg = macchiato.base,
							-- 	style = { "bold,italic" },
							-- }, -- current
							-- BufferLineIndicatorSelected = {
							-- 	bg = macchiato.teal,
							-- },
							-- -- -- separators
							-- BufferLineSeparator = {
							-- 	bg = util.darken(macchiato.base, 0.8),
							-- 	fg = util.darken(macchiato.base, 0.8),
							-- },
							-- BufferLineSeparatorSelected = {
							-- 	bg = macchiato.base,
							-- 	fg = macchiato.base,
							-- },
							-- Neotree
							NeoTreeNormal = { fg = macchiato.text, bg = util.darken(macchiato.base, 0.8) },
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
			vim.api.nvim_command("colorscheme catppuccin-macchiato")
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

-- BufferLineHintVisible xxx cterm= gui= guifg=#0088ff guibg=#1e3c53
-- BufferLineHintSelected xxx cterm=bold,italic gui=bold,italic guifg=#00c8a0 guibg=#21425b guisp=#00c8a0
-- BufferLineHintDiagnostic xxx cterm= gui= guifg=#0066bf guibg=#183144 guisp=#009678
-- BufferLineHintDiagnosticVisible xxx cterm= gui= guifg=#0066bf guibg=#1e3c53
-- BufferLineHintDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#009678 guibg=#21425b guisp=#009678
-- BufferLineInfoVisible xxx cterm= gui= guifg=#0088ff guibg=#1e3c53
-- BufferLineInfoSelected xxx cterm=bold,italic gui=bold,italic guifg=#90ebed guibg=#21425b guisp=#90ebed
-- BufferLineInfoDiagnostic xxx cterm= gui= guifg=#0066bf guibg=#183144 guisp=#6cb0b1
-- BufferLineInfoDiagnosticVisible xxx cterm= gui= guifg=#0066bf guibg=#1e3c53
-- BufferLineInfoDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#6cb0b1 guibg=#21425b guisp=#6cb0b1
-- BufferLineTabClose xxx cterm= gui= guifg=#0088ff guibg=#183144
-- BufferLineCloseButton xxx cterm= gui= guifg=#0088ff guibg=#183144
-- BufferLineCloseButtonVisible xxx cterm= gui= guifg=#0088ff guibg=#1e3c53
-- BufferLineCloseButtonSelected xxx cterm= gui= guifg=#e2effe guibg=#21425b
-- BufferLineBufferVisible xxx cterm= gui= guifg=#0088ff guibg=#1e3c53
-- BufferLineErrorSelected xxx cterm=bold,italic gui=bold,italic guifg=#d45a7e guibg=#21425b guisp=#d45a7e
-- BufferLineErrorDiagnostic xxx cterm= gui= guifg=#0066bf guibg=#183144 guisp=#9f435e
-- BufferLineErrorDiagnosticVisible xxx cterm= gui= guifg=#0066bf guibg=#1e3c53
-- BufferLineErrorDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#9f435e guibg=#21425b guisp=#9f435e
-- BufferLineModifiedVisible xxx cterm= gui= guifg=#97ea88 guibg=#1e3c53
-- BufferLineModifiedSelected xxx cterm= gui= guifg=#97ea88 guibg=#21425b
-- BufferLineDuplicateSelected xxx cterm=italic gui=italic guifg=#0081f2 guibg=#21425b
-- BufferLineDuplicateVisible xxx cterm=italic gui=italic guifg=#0081f2 guibg=#1e3c53
-- BufferLineDuplicate xxx cterm=italic gui=italic guifg=#0081f2 guibg=#183144
-- BufferLinePick xxx cterm=bold,italic gui=bold,italic guifg=#d45a7e guibg=#183144
-- BufferLineSeparatorVisible xxx cterm= gui= guifg=#122432 guibg=#1e3c53
-- BufferLineTabSeparator xxx cterm= gui= guifg=#122432 guibg=#183144
-- BufferLineTabSeparatorSelected xxx cterm= gui= guifg=#122432 guibg=#21425b
-- BufferLineIndicatorVisible xxx cterm= gui= guifg=#1e3c53 guibg=#1e3c53
-- BufferLinePickSelected xxx cterm=bold,italic gui=bold,italic guifg=#d45a7e guibg=#21425b
-- BufferLinePickVisible xxx cterm=bold,italic gui=bold,italic guifg=#d45a7e guibg=#1e3c53
-- BufferLineOffsetSeparator xxx guifg=#00c8a0
-- BufferLineWarningSelected xxx cterm=bold,italic gui=bold,italic guifg=#ffd701 guibg=#21425b guisp=#ffd701
-- BufferLineWarningDiagnostic xxx cterm= gui= guifg=#0066bf guibg=#183144 guisp=#bfa100
-- BufferLineWarningDiagnosticVisible xxx cterm= gui= guifg=#0066bf guibg=#1e3c53
-- BufferLineWarningDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#bfa100 guibg=#21425b guisp=#bfa100
-- BufferLineHint xxx cterm= gui= guifg=#0088ff guibg=#183144 guisp=#00c8a0
-- BufferLineModified xxx cterm= gui= guifg=#97ea88 guibg=#183144
-- BufferLineBackground xxx cterm= gui= guifg=#0088ff guibg=#183144
-- BufferLineWarning xxx cterm= gui= guifg=#0088ff guibg=#183144 guisp=#ffd701
-- BufferLineSeparatorSelected xxx cterm= gui= guifg=#122432 guibg=#21425b
-- BufferLineError xxx cterm= gui= guifg=#0088ff guibg=#183144 guisp=#d45a7e
-- BufferLineNumbersSelected xxx cterm=bold,italic gui=bold,italic guifg=#e2effe guibg=#21425b
-- BufferLineNumbersVisible xxx cterm= gui= guifg=#0088ff guibg=#1e3c53
--
--
-- NeoTreeNormalNC xxx links to NormalNC
-- NeoTreeSignColumn xxx links to SignColumn
-- NeoTreeStatusLine xxx links to StatusLine
-- NeoTreeStatusLineNC xxx links to StatusLineNC
-- NeoTreeVertSplit xxx links to VertSplit
-- NeoTreeWinSeparator xxx links to WinSeparator
-- NeoTreeEndOfBuffer xxx links to EndOfBuffer
-- NeoTreeFloatBorder xxx links to FloatBorder
-- NeoTreeFloatTitle xxx guifg=#e2effe
-- NeoTreeTitleBar xxx guifg=#1e3b52 guibg=#0088ff
-- NeoTreeBufferNumber xxx links to SpecialChar
-- NeoTreeDimText xxx guifg=#505050
-- NeoTreeMessage xxx gui=italic guifg=#505050
-- NeoTreeFadeText1 xxx guifg=#626262
-- NeoTreeFadeText2 xxx guifg=#444444
-- NeoTreeDotfile xxx guifg=#626262
-- NeoTreeHiddenByName xxx links to NeoTreeDotfile
-- NeoTreeCursorLine xxx links to CursorLine
-- NeoTreeFileIcon xxx links to NeoTreeDirectoryIcon
-- NeoTreeFileName xxx cleared
-- NeoTreeFilterTerm xxx links to SpecialChar
-- NeoTreeRootName xxx gui=bold,italic
-- NeoTreeExpander xxx links to NeoTreeDimText
-- NeoTreeModified xxx guifg=#d7d787
-- NeoTreeWindowsHidden xxx links to NeoTreeDotfile
-- NeoTreePreview xxx links to Search
-- NeoTreeGitAdded xxx links to GitSignsAdd
-- NeoTreeGitDeleted xxx links to GitSignsDelete
-- NeoTreeGitConflict xxx gui=bold,italic guifg=#ff8700
-- NeoTreeGitIgnored xxx links to NeoTreeDotfile
-- NeoTreeGitRenamed xxx links to NeoTreeGitModified
-- NeoTreeGitStaged xxx links to NeoTreeGitAdded
-- NeoTreeGitUnstaged xxx links to NeoTreeGitConflict
-- NeoTreeGitUntracked xxx gui=italic guifg=#ff8700
-- NeoTreeTabActive xxx gui=bold
-- NeoTreeTabInactive xxx guifg=#777777 guibg=#141414
-- NeoTreeTabSeparatorActive xxx guifg=#0a0a0a
-- NeoTreeTabSeparatorInactive xxx guifg=#101010 guibg=#141414
