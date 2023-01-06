return {
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
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"p00f/nvim-ts-rainbow",
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
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		config = function()
			require("config._telescope").setup()
		end,
	},
	{ "cljoly/telescope-repo.nvim" },

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

	{ "nvim-pack/nvim-spectre" },

	-- Startup page

	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config._alpha").setup()
		end,
	},

	-- LSP & Completion

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
		},
		-- config = function()
		-- 	require("config.lsp")
		-- end,
	},

	-- Utils

	{
		"folke/which-key.nvim",
		keys = "<space>",
		config = function()
			require("config._whichkey")
		end,
	},

	{
		"karb94/neoscroll.nvim",
		keys = { "<C-u>", "<C-d>", "gg", "G" },
		config = function()
			require("config._neoscroll").setup()
		end,
	},

	-- {
	-- 	"steelsojka/pears.nvim",
	-- 	event = "InsertEnter",
	-- 	config = true,
	-- },

	{
		"numToStr/Comment.nvim",
		keys = { "gc" },
		config = true,
	},

	{
		"kylechui/nvim-surround",
		keys = { "ys", "ds", "cs" },
		config = true,
	},

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

	{ "mattn/emmet-vim" },

	-- Git Utils

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
	{
		"abecodes/tabout.nvim",
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>",
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		config = function()
			require("symbols-outline").setup()
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
		"phaazon/hop.nvim",
		branch = "v2",
		lazy = false,
		-- cmd = { "HopPattern", "HopLineBC", "HopLineAC" },
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
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
	{ "stevearc/dressing.nvim" },
	{ "mg979/vim-visual-multi" },
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
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"smjonas/inc-rename.nvim",
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
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
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
	{ "kdheepak/lazygit.nvim", cmd = { "LazyGit" } },
	{
		"emmanueltouzery/agitator.nvim",
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
	{ "mrshmllow/document-color.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
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
	{
		"luukvbaal/nnn.nvim",
		cmd = { "NnnPicker" },
		config = function()
			require("nnn").setup()
		end,
	},
}
