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

		use({ "nvim-lua/plenary.nvim", module = "plenary" })
		---- UI
		-- Colorscheme
		use({
			"lalitmee/cobalt2.nvim",
			requires = "tjdevries/colorbuddy.nvim",
		})

		-- Startup screen
		use({
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha").setup()
			end,
		})

		-- Better icons
		use({
			"kyazdani42/nvim-web-devicons",
			module = "nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({ default = true })
			end,
		})

		use({
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			after = "nvim-treesitter",
			config = function()
				require("config.lualine").setup()
			end,
			wants = "nvim-web-devicons",
		})

		use({
			"SmiteshP/nvim-gps",
			requires = "nvim-treesitter/nvim-treesitter",
			module = "nvim-gps",
			wants = "nvim-treesitter",
			config = function()
				require("nvim-gps").setup()
			end,
		})
		-- Buffer line
		use({
			"akinsho/nvim-bufferline.lua",
			event = "BufReadPre",
			wants = "nvim-web-devicons",
			config = function()
				require("config.bufferline").setup()
			end,
		})

		---- LSP & Treesitter & Autocomplete
		-- Cmp
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
				{
					"L3MON4D3/LuaSnip",
					wants = "friendly-snippets",
					config = function()
						require("config.luasnip").setup()
					end,
				},
				"rafamadriz/friendly-snippets",
				disable = false,
			},
		})
		-- Lsp
		use({
			"neovim/nvim-lspconfig",
			opt = true,
			event = "BufReadPre",
			wants = { "nvim-lsp-installer", "cmp-nvim-lsp", "lua-dev.nvim", "vim-illuminate" },
			config = function()
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/nvim-lsp-installer",
				"folke/lua-dev.nvim",
				"RRethy/vim-illuminate",
			},
		})

		use({
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			opt = true,
			event = "BufRead",
		})

		-- Lsp Zero
		-- use({
		-- 	"VonHeikemen/lsp-zero.nvim",
		-- 	requires = {
		-- 		-- LSP Support
		-- 		{ "neovim/nvim-lspconfig" },
		-- 		{ "williamboman/nvim-lsp-installer" },
		--
		-- 		-- Autocompletion
		-- 		{ "hrsh7th/nvim-cmp" },
		-- 		{ "hrsh7th/cmp-buffer" },
		-- 		{ "hrsh7th/cmp-path" },
		-- 		{ "hrsh7th/cmp-cmdline" },
		-- 		{ "saadparwaiz1/cmp_luasnip" },
		-- 		{ "hrsh7th/cmp-nvim-lsp" },
		-- 		{ "hrsh7th/cmp-nvim-lua" },
		--
		-- 		-- Snippets
		-- 		{ "L3MON4D3/LuaSnip" },
		-- 		{ "rafamadriz/friendly-snippets" },
		-- 	},
		-- 	config = function()
		-- 		require("config.lsp").setup()
		-- 	end,
		-- })

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			opt = true,
			event = "BufRead",
			run = ":TSUpdate",
			config = function()
				require("config.treesitter").setup()
			end,
			requires = {
				{ "nvim-treesitter/nvim-treesitter-textobjects" },
			},
		})

		-- Diagnostics
		use({
			"folke/trouble.nvim",
			event = "BufReadPre",
			wants = "nvim-web-devicons",
			cmd = { "TroubleToggle", "Trouble" },
			config = function()
				require("trouble").setup({
					use_diagnostic_signs = true,
				})
			end,
		})

		-- lspsaga.nvim
		use({
			"tami5/lspsaga.nvim",
			event = "VimEnter",
			cmd = { "Lspsaga" },
			config = function()
				require("lspsaga").setup({})
			end,
		})

		-- Automated code formatting
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("config/null-ls").setup()
			end,
		})

		-- Code Actions
		use({
			"weilbith/nvim-code-action-menu",
		})

		---- Utils
		--Wordmotion
		use({ "chaoren/vim-wordmotion" })
		--fzf
		use({
			"ibhagwan/fzf-lua",
			requires = { "kyazdani42/nvim-web-devicons" },
		})

		--Surround
		use({
			"tpope/vim-surround",
		})

		-- Multiple cursors
		use({
			"mg979/vim-visual-multi",
		})

		-- Correct pwd
		use({
			"airblade/vim-rooter",
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

		-- Easy motion
		use({
			"ggandor/lightspeed.nvim",
			keys = { "s", "S", "f", "F", "t", "T" },
			config = function()
				require("lightspeed").setup({})
			end,
		})

		-- End wise
		use({
			"RRethy/nvim-treesitter-endwise",
			wants = "nvim-treesitter",
			event = "InsertEnter",
		})

		-- Auto tag
		use({
			"windwp/nvim-ts-autotag",
			wants = "nvim-treesitter",
			event = "InsertEnter",
			config = function()
				require("nvim-ts-autotag").setup({ enable = true })
			end,
		})

		-- Autopair brackets
		use({
			"windwp/nvim-autopairs",
			wants = "nvim-treesitter",
			module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
			config = function()
				require("config.autopairs").setup()
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

		-- -- Expand Region
		-- use({
		-- 	"olambo/vi-viz",
		-- })

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

		-- Console.log statements
		use({ "gaelph/logsitter.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })

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
		use({
			"nvim-telescope/telescope.nvim",
			config = function()
				require("config.telescope").setup()
			end,
			cmd = { "Telescope" },
			module = { "telescope", "telescope.builtin" },
			keys = { "<leader>f", "<leader>p", "<leader>z" },
			wants = {
				"plenary.nvim",
				"popup.nvim",
				"telescope-fzf-native.nvim",
				"telescope-project.nvim",
				"telescope-repo.nvim",
				"telescope-file-browser.nvim",
				"project.nvim",
			},
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				"nvim-telescope/telescope-project.nvim",
				"cljoly/telescope-repo.nvim",
				"nvim-telescope/telescope-file-browser.nvim",
				{
					"ahmedkhalf/project.nvim",
					config = function()
						require("project_nvim").setup({})
					end,
				},
			},
		})

		---- Tools
		-- Ranger
		use({
			"kevinhwang91/rnvimr",
		})

		-- Git
		use({
			"kdheepak/lazygit.nvim",
			cmd = "LazyGit",
		})

		-- Nvim-tree
		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons",
			},
			cmd = { "NvimTreeToggle", "NvimTreeClose" },
			config = function()
				require("config.nvimtree").setup()
			end,
		})

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
			ft = "markdown",
			cmd = { "MarkdownPreview" },
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
