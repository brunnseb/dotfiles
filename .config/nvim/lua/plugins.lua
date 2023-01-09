return {

	-- UI

	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config._alpha").setup()
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("config._catppuccin").setup()
		end,
		build = ":CatppuccinCompile",
		lazy = false,
	},
	{
		"kyazdani42/nvim-web-devicons",
		event = "BufRead",
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config._lualine").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPre",
		config = function()
			require("config._bufferline").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("config._blankline").setup()
		end,
	},
	{
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		dependencies = { "folke/twilight.nvim" },
		config = function()
			require("config._zen").setup()
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				top_down = false,
			})
			vim.notify = require("notify")
		end,
	},
	{
		"folke/noice.nvim",
		lazy = false,
		config = function()
			require("config._noice").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{ "stevearc/dressing.nvim" },
	{ "mrshmllow/document-color.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
			})
		end,
	},

	-- NAVIGATION

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		lazy = false,
		-- cmd = "Telescope",
		config = function()
			require("config._telescope").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					undo = {
						-- telescope-undo.nvim config, see below
					},
				},
			})
			require("telescope").load_extension("undo")
			-- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
		end,
	},
	{ "cljoly/telescope-repo.nvim" },
	{ "nvim-pack/nvim-spectre" },
	{
		"karb94/neoscroll.nvim",
		keys = { "<C-u>", "<C-d>", "gg", "G" },
		config = function()
			require("config._neoscroll").setup()
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
		lazy = false,
		-- cmd = { "HopPattern", "HopLineBC", "HopLineAC" },
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},

	-- GIT

	{ "kdheepak/lazygit.nvim", cmd = { "LazyGit" } },
	{
		"emmanueltouzery/agitator.nvim",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config._gitsigns").setup()
		end,
	},

	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		config = function()
			require("config._diffview").setup()
		end,
	},

	{
		"akinsho/git-conflict.nvim",
		cmd = { "GitConflictListQf" },
		config = true,
	},
	-- LSP
	{
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
	},

	{
		"glepnir/lspsaga.nvim",
		cmd = { "Lspsaga" },
		config = function()
			local saga = require("lspsaga")

			saga.init_lsp_saga({
				custom_kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
			})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		config = {
			auto_open = false,
			use_diagnostic_signs = true,
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufRead" },
		commit = "cdef04dfad2d1a6d76f596ac63600e7430baaabe",
		config = function()
			require("config._null-ls").setup()
		end,
	},
	{ "b0o/schemastore.nvim" },
	{
		"jose-elias-alvarez/typescript.nvim",
		config = function()
			require("config._typescript").setup()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		config = function()
			require("symbols-outline").setup()
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		cmd = { "IncRename" },
		config = function()
			require("inc_rename").setup()
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "LspAttach",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			require("config._ufo").setup()
		end,
	},

	-- TREESITTER

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"mrjones2014/nvim-ts-rainbow",
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/playground",
		},
		build = ":TSUpdate",
		event = "BufReadPost",
		cmd = "TSUpdate",
		config = function()
			require("config._treesitter").setup()
		end,
	},

	-- FILE-MANAGEMENT

	{
		"luukvbaal/nnn.nvim",
		cmd = { "NnnPicker" },
		config = function()
			require("nnn").setup()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config._neotree").setup()
		end,
	},

	-- COMPLETION & SNIPPETS

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			require("config._cmp").setup()
		end,
	},

	-- UTILS

	{
		"jackMort/ChatGPT.nvim",
		cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions" },
		config = function()
			require("chatgpt").setup({
				-- optional configuration
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"anuvyklack/windows.nvim",
		cmd = {
			"WindowsMaximize",
			"WindowsMaximizeVertically",
			"WindowsMaximizeHorizontally",
			"WindowsEqualize",
			"WindowsEnableAutowidth",
			"WindowsDisableAutowidth",
			"WindowsToggleAutowidth",
		},
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup()
		end,
	},

	{
		"folke/which-key.nvim",
		keys = "<space>",
		config = function()
			require("config._whichkey")
		end,
	},
	{
		"numToStr/Comment.nvim",
		keys = { "gc" },
		config = true,
	},
	{
		"kylechui/nvim-surround",
		lazy = false,
		-- keys = { "S", "ys", "ds", "cs" },
		config = true,
	},
	{ "mattn/emmet-vim" },
	{
		"abecodes/tabout.nvim",
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>",
			})
		end,
	},
	{ "lewis6991/impatient.nvim", lazy = false },
	{ "nathom/filetype.nvim", lazy = false },
	{ "chaoren/vim-wordmotion", event = "BufRead" },
	{ "andymass/vim-matchup" },
	{ "jinh0/eyeliner.nvim" },
	{
		"axelvc/template-string.nvim",
		config = function()
			require("template-string").setup({})
		end,
	},
	{

		"kkoomen/vim-doge",
		build = ":call doge#install()",
	},
	{
		"notjedi/nvim-rooter.lua",
		lazy = false,
		config = function()
			require("config._nvim-rooter").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTelescope" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{ "gaelph/logsitter.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{ "mg979/vim-visual-multi" },
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		config = function()
			require("config._neorg").setup()
		end,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("config._term").setup()
		end,
	},
	{
		"EthanJWright/vs-tasks.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("config._tasks").setup()
		end,
	},

	-- TESTING

	{
		"nvim-neotest/neotest",
		dependencies = {
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
	},
}
