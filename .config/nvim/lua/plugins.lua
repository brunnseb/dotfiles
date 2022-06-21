local M = {}

function M.setup()
	-- Indicate first time installation
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},

		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},
	}

	-- Check if packer.nvim is installed
	-- Run PackerCompile if there are changes in this file
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system({
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			})
			vim.cmd([[packadd packer.nvim]])
		end
		vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
	end

	-- Plugins
	local function plugins(use)
		use({ "wbthomason/packer.nvim" })

		-- Completion
		use({
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			opt = true,
			config = function()
				require("config.cmp").setup()
			end,
			wants = { "LuaSnip" },
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"ray-x/cmp-treesitter",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				-- "onsails/lspkind-nvim",
				-- "hrsh7th/cmp-calc",
				-- "f3fora/cmp-spell",
				-- "hrsh7th/cmp-emoji",
				{
					"L3MON4D3/LuaSnip",
					wants = { "friendly-snippets", "vim-snippets" },
				},
				"rafamadriz/friendly-snippets",
				"honza/vim-snippets",
			},
		})

		use({ "nvim-pack/nvim-spectre", module = "spectre", keys = { "<leader>s" } })

		use({ "gaelph/logsitter.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })

		-- use({
		-- 	"nvim-neotest/neotest",
		-- 	requires = {
		-- 		"nvim-lua/plenary.nvim",
		-- 		"nvim-treesitter/nvim-treesitter",
		-- 		"antoinemadec/FixCursorHold.nvim",
		-- 		"haydenmeade/neotest-jest",
		-- 	},
		-- 	config = function()
		-- 		require("neotest").setup({
		-- 			adapters = {
		-- 				require("neotest-jest")({
		-- 					jestCommand = "yarn test",
		-- 				}),
		-- 			},
		-- 		})
		-- 	end,
		-- })

		use({
			"kevinhwang91/nvim-bqf",
			config = function()
				require("bqf").setup({
					func_map = {
						nextfile = "<C-j>",
						prevfile = "<C-k>",
					},
					preview = {
						auto_preview = false,
					},
				})
			end,
		})

		-- Git
		use({
			"lewis6991/gitsigns.nvim",
			event = "BufReadPre",
			wants = "plenary.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("config.gitsigns").setup()
			end,
		})
		use({
			"tpope/vim-fugitive",
			opt = true,
			commit = "92c73bb0507338441733198d630a1fe5e7fdac3a",
			cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
			requires = { "tpope/vim-rhubarb", "idanarye/vim-merginal" },
			wants = { "vim-rhubarb" },
		})

		use({ "junegunn/gv.vim" })
		use({
			"akinsho/git-conflict.nvim",
			cmd = {
				"GitConflictChooseTheirs",
				"GitConflictChooseOurs",
				"GitConflictChooseBoth",
				"GitConflictChooseNone",
				"GitConflictNextConflict",
				"GitConflictPrevConflict",
				"GitConflictListQf",
			},
			config = function()
				require("git-conflict").setup()
			end,
		})
		-- use({
		-- 	"tanvirtin/vgit.nvim",
		-- 	requires = { "nvim-lua/plenary.nvim" },
		-- 	cmd = { "VGit" },
		-- 	config = function()
		-- 		require("vgit").setup()
		-- 	end,
		-- })

		-- Performance
		use({ "lewis6991/impatient.nvim" })

		-- Diffview
		-- use({
		-- 	"sindrets/diffview.nvim",
		-- 	requires = "nvim-lua/plenary.nvim",
		-- 	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
		-- })

		-- Notification
		use({
			"rcarriga/nvim-notify",
			event = "BufReadPre",
			config = function()
				require("config.notify").setup()
			end,
		})

		-- Essentials
		use({ "andymass/vim-matchup", event = "CursorMoved" })
		use({ "wellle/targets.vim", event = "CursorMoved" })
		use({ "unblevable/quick-scope", event = "CursorMoved", disable = false })
		use({ "google/vim-searchindex", event = "BufReadPre" })

		use({
			"chentoast/marks.nvim",
			event = "BufReadPre",
			config = function()
				require("marks").setup({})
			end,
		})

		use({
			"ahmedkhalf/project.nvim",
			event = "VimEnter",
			config = function()
				require("project_nvim").setup({})
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "kyazdani42/nvim-web-devicons" },
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				{ "nvim-telescope/telescope-project.nvim" },
			},
			config = function()
				require("config.telescope").setup()
			end,
		})

		use({
			"VonHeikemen/lsp-zero.nvim",
			event = "BufRead",
			requires = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" },
				{ "williamboman/nvim-lsp-installer" },

				-- Autocompletion
				-- { "hrsh7th/nvim-cmp" },
				-- { "hrsh7th/cmp-buffer" },
				-- { "hrsh7th/cmp-path" },
				-- { "saadparwaiz1/cmp_luasnip" },
				-- { "hrsh7th/cmp-nvim-lsp" },
				-- { "hrsh7th/cmp-nvim-lua" },

				-- Snippets
				{ "L3MON4D3/LuaSnip" },
				{ "rafamadriz/friendly-snippets" },

				{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
				{
					"folke/trouble.nvim",
					requires = "kyazdani42/nvim-web-devicons",
					config = function()
						require("trouble").setup({})
					end,
				},
				{ "tami5/lspsaga.nvim" },
			},
			config = function()
				require("config.lsp").setup()
			end,
		})

		-- use({ "airblade/vim-rooter" })

		use({
			"is0n/fm-nvim",
			config = function()
				require("config.fm").setup()
			end,
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("config.treesitter").setup()
			end,
			requires = {
				{
					"nvim-treesitter/nvim-treesitter-textobjects",
				},
				{ "RRethy/nvim-treesitter-textsubjects" },
				{
					"windwp/nvim-autopairs",
					run = "make",
					config = function()
						require("nvim-autopairs").setup({})
					end,
				},
				{
					"windwp/nvim-ts-autotag",
					config = function()
						require("nvim-ts-autotag").setup({ enable = true })
					end,
				},
				{
					"romgrk/nvim-treesitter-context",
					config = function()
						require("treesitter-context").setup({ enable = true })
					end,
				},
				{
					"mfussenegger/nvim-ts-hint-textobject",
					config = function()
						vim.cmd([[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]])
						vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]])
					end,
				},
				{ "JoosepAlviste/nvim-ts-context-commentstring" },
				{ "p00f/nvim-ts-rainbow" },
			},
		})

		use({ "dstein64/vim-startuptime" })

		use({ "nvim-lua/plenary.nvim", module = "plenary" })
		---- UI
		use({
			"brunnseb/catppuccin",
			-- "~/Development/forks/catppuccin",
			as = "catppuccin",
			config = function()
				require("catppuccin").setup()
			end,
		})

		-- Startup screen
		use({
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha").setup()
			end,
		})

		-- Automated code formatting
		use({
			"jose-elias-alvarez/null-ls.nvim",
			event = { "BufRead" },
			config = function()
				require("config/null-ls").setup()
			end,
		})

		--Wordmotion
		use({ "chaoren/vim-wordmotion" })

		--Surround
		use({
			"tpope/vim-surround",
		})

		-- Multiple cursors
		use({
			"mg979/vim-visual-multi",
		})

		-- File types
		use({
			"nathom/filetype.nvim",
		})

		-- Avy replacement
		use({
			"phaazon/hop.nvim",
			cmd = { "HopLineAC", "HopLineBC", "HopPatter" },
			branch = "v1",
			config = function()
				require("config.hop").setup()
			end,
		})

		---- Org
		-- Neorg
		use({
			"nvim-neorg/neorg",
			requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
			config = function()
				require("config.neorg").setup()
			end,
		})

		-- Gkeep integration
		use({
			"stevearc/gkeep.nvim",
			run = ":UpdateRemotePlugins",
		})

		-- Better Escape
		use({
			"max397574/better-escape.nvim",
			config = function()
				require("config.better-escape").setup()
			end,
		})

		-- Which Key
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				require("config.whichkey").setup()
			end,
		})

		-- Comment
		use({
			"terrortylor/nvim-comment",
			opt = true,
			keys = { "gc", "gcc", "gbc" },
			config = function()
				require("nvim_comment").setup()
			end,
		})

		---- Search & Navigation
		-- Telescope
		--
		---- Tools
		-- Toggle Terminal
		use({
			"akinsho/toggleterm.nvim",
			tag = "v1.*",
			config = function()
				require("toggleterm").setup()
			end,
		})

		if packer_bootstrap then
			print("Restart Neovim required after installation!")
			require("packer").sync()
		end
	end

	packer_init()

	local packer = require("packer")
	packer.init(conf)
	packer.startup(plugins)
end

return M
