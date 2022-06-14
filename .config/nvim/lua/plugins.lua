local M = {}

function M.setup()
	-- Indicate first time installation
	local packer_bootstrap = false
	local actions = require("telescope.actions")

	-- packer.nvim configuration
	local conf = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
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

		use({
			"weilbith/nvim-code-action-menu",
		})

		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("config/null-ls").setup()
			end,
		})

		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})

		use({
			"tpope/vim-surround",
		})

		use({
			"mg979/vim-visual-multi",
		})

		use({
			"airblade/vim-rooter",
		})

		use({
			"phaazon/hop.nvim",
			branch = "v1", -- optional but strongly recommended
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			end,
		})

		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})

		use({
			"nvim-neorg/neorg",
			config = function()
				require("neorg").setup({
					load = {
						["core.defaults"] = {},
						["core.integrations.telescope"] = {},
					},
				})
			end,
			requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
		})

		use({
			"stevearc/gkeep.nvim",
			run = ":UpdateRemotePlugins",
		})

		use({
			"jose-elias-alvarez/typescript.nvim",
			config = function()
				require("typescript").setup()
			end,
		})

		use({
			"VonHeikemen/lsp-zero.nvim",
			requires = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" },
				{ "williamboman/nvim-lsp-installer" },

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-cmdline" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-nvim-lua" },

				-- Snippets
				{ "L3MON4D3/LuaSnip" },
				{ "rafamadriz/friendly-snippets" },
			},
			config = function()
				require("config/lsp").setup()
			end,
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("nvim-treesitter").setup({
					ensure_installed = {
						"javascript",
						"typescript",
						"css",
						"html",
						"json",
						"svelte",
						"graphql",
						"yaml",
					},
					highlight = {
						enable = true,
					},
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "gnn",
							node_incremental = "grn",
							scope_incremental = "grc",
							node_decremental = "grm",
						},
					},
				})
			end,
		})

		use({ "gaelph/logsitter.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("telescope").setup({
					extensions = {
						fzf = {
							fuzzy = true, -- false will only do exact matching
							override_generic_sorter = true, -- override the generic sorter
							override_file_sorter = true, -- override the file sorter
							case_mode = "smart_case", -- or "ignore_case" or "respect_case"
							-- the default case_mode is "smart_case"
						},
					},
					defaults = {
						mappings = {
							i = {
								["<C-j>"] = actions.move_selection_next,
								["<C-k>"] = actions.move_selection_previous,
								["<C-n>"] = actions.cycle_history_next,
								["<C-p>"] = actions.cycle_history_prev,
							},
						},
					},
				})
			end,
		})

		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		})

		use({
			"nvim-telescope/telescope-project.nvim",
			config = function()
				require("telescope").load_extension("project")
			end,
		})

		use({
			"cljoly/telescope-repo.nvim",
			config = function()
				require("telescope").load_extension("repo")
			end,
		})

		use({
			"LinArcX/telescope-env.nvim",
			config = function()
				require("telescope").load_extension("env")
			end,
		})

		-- Colorscheme
		use({
			"lalitmee/cobalt2.nvim",
			requires = "tjdevries/colorbuddy.nvim",
		})

		use({
			"olambo/vi-viz",
		})

		-- Better Escape
		use({
			"max397574/better-escape.nvim",
			config = function()
				require("better_escape").setup({
					mapping = { "jk" }, -- a table with mappings to use
				})
			end,
		})

		-- Which Key
		use({
			"folke/which-key.nvim",
			config = function()
				require("config.whichkey").setup()
			end,
		})

		-- Ranger
		use({
			"francoiscabrol/ranger.vim",
		})

		-- Startup screen
		use({
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha").setup()
			end,
		})

		-- Comment
		use({
			"terrortylor/nvim-comment",
			config = function()
				require("nvim_comment").setup()
			end,
		})

		-- Git
		-- use {
		--   "TimUntersberger/neogit",
		--   requires = "nvim-lua/plenary.nvim",
		--   config = function()
		--     require("config.neogit").setup()
		--   end,
		-- }
		use({
			"kdheepak/lazygit.nvim",
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
