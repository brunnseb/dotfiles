local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")

if not mason_ok or not mason_lsp_ok then
	return
end

mason.setup({
	ui = {
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "rounded",
	},
})

mason_lsp.setup({
	ensure_installed = {
		"bashls",
		"cssls",
		"cssmodules_ls",
		"eslint",
		"html",
		"jsonls",
		"tailwindcss",
		"tsserver",
		"sumneko_lua",
	},

	automatic_installation = true,
})

local lspconfig = require("lspconfig")
local default_options = require("lsp.defaults")
local helpers = require("lsp.helpers")
require("neodev").setup({})

mason_lsp.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup(default_options)
	end,

	["cssmodules_ls"] = function()
		lspconfig.cssmodules_ls.setup(vim.tbl_deep_extend("force", default_options, {
			root_dir = function(filename, _)
				return helpers.compose_root_dir({}, filename)
			end,
		}))
	end,

	["tailwindcss"] = function()
		lspconfig.tailwindcss.setup(vim.tbl_deep_extend("force", default_options, {
			capabilities = {
				textDocument = { completion = { completionItem = { snippetSupport = true } } },
			},
			root_dir = function(filename, _)
				return helpers.compose_root_dir({
					"tailwind.config.json",
					"tailwind.config.ts",
					"postcss.config.js",
					"postcss.config.ts",
				}, filename)
			end,
			settings = {
				tailwindCSS = {
					experimental = {
						configFile = {
							["apps/portal/tailwind.config.js"] = "apps/portal/**",
							["apps/public-forms/tailwind.config.js"] = "apps/public-forms/**",
							["libs/cockpit-core/tailwind.config.js"] = { "apps/cockpit/**", "libs/**" },
						},
					},
				},
			},
		}))
	end,

	["emmet_ls"] = function()
		lspconfig.emmet_ls.setup(vim.tbl_deep_extend("force", default_options, {
			capabilities = {
				textDocument = { completion = { completionItem = { snippetSupport = true } } },
			},
		}))
	end,

	["cssls"] = function()
		lspconfig.cssls.setup(vim.tbl_deep_extend("force", default_options, {
			capabilities = {
				textDocument = { completion = { completionItem = { snippetSupport = true } } },
			},
		}))
	end,

	["jsonls"] = function()
		lspconfig.jsonls.setup(vim.tbl_deep_extend("force", default_options, {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
			setup = {
				commands = {
					Format = {
						function()
							vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
						end,
					},
				},
			},
			capabilities = {
				textDocument = { completion = { completionItem = { snippetSupport = true } } },
			},
		}))
	end,

	["sumneko_lua"] = function()
		lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", default_options, {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = runtime_path,
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		}))
	end,

	["eslint"] = function()
		lspconfig.eslint.setup(vim.tbl_deep_extend("force", default_options, {
			root_dir = function(filename, _)
				return helpers.compose_root_dir({
					".eslintrc",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json",
				}, filename)
			end,
		}))
	end,
})
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspAttach_inlayhints",
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
})
