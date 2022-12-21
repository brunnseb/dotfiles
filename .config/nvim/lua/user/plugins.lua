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
	use({
		"abecodes/tabout.nvim",
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>",
			})
		end,
	})
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	})
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
	use({ "andymass/vim-matchup" })
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
			require("notify").setup({
				top_down = false,
			})
			vim.notify = require("notify")
		end,
	})
	use({
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				messages = {
					-- NOTE: If you enable messages, then the cmdline is enabled automatically.
					-- This is a current Neovim limitation.
					enabled = true, -- enables the Noice messages UI
					view = "notify", -- default view for messages
					view_error = "notify", -- view for errors
					view_warn = "notify", -- view for warnings
					view_history = "messages", -- view for :messages
					view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
				},
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})
	use({
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	})
	use({
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	})

	use({
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
			require("user.plugins._ufo").setup()
		end,
	})
	-- Neotest
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "pnpm test -- --passWithNoTests",
						cwd = function()
							print("path " .. vim.fn.expand("%:p:h"))
							return vim.fn.expand("%:p:h")
						end,
					}),
				},
			})
		end,
	})

	-- Neorg
	use({
		"nvim-neorg/neorg",
		run = ":Neorg sync-parsers",
		config = function()
			require("user.plugins._neorg").setup()
		end,
		requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
	})
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("user.plugins._term").setup()
		end,
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

	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	use({
		"folke/zen-mode.nvim",
		requires = "folke/twilight.nvim",
		config = function()
			require("user.plugins._zen").setup()
		end,
	})

	-- Git
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "kdheepak/lazygit.nvim" })
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

	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("user.plugins._catppuccin").setup()
		end,
	})

	use({
		"EthanJWright/vs-tasks.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("user.plugins._tasks").setup()
		end,
	})
	-- DAP
	-- use({
	-- 	"theHamsta/nvim-dap-virtual-text",
	-- 	config = function()
	-- 		require("user.plugins._dap").virtual.setup()
	-- 	end,
	-- })
	-- use({
	-- 	"rcarriga/nvim-dap-ui",
	-- 	config = function()
	-- 		require("user.plugins._dap").ui.setup()
	-- 	end,
	-- })
	-- use({
	-- 	"mfussenegger/nvim-dap",
	-- 	config = function()
	-- 		require("user.plugins._dap").dap.setup()
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

			saga.init_lsp_saga({
				custom_kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
			})
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
