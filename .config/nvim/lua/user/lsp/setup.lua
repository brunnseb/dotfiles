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
		"bash-language-server",
		"css-lsp",
		"cssmodules-language-server",
		"eslint-lsp",
		"graphql-language-service-cli",
		"html-lsp",
		"json-lsp",
		"lua-language-server",
		"tailwindcss-language-server",
		"typescript-language-server",
		"firefox-debug-adapter",
		"node-debug2-adapter",
		"svelte-language-server",
		"sumneko_lua",
	},

	automatic_installation = true,
})

local lspconfig = require("lspconfig")
local default_options = require("user.lsp.defaults")

mason_lsp.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup(default_options)
	end,

	["emmet_ls"] = function()
		lspconfig.emmet_ls.setup({
			vim.tbl_deep_extend("force", default_options, {
				capabilities = {
					textDocument = { completion = { completionItem = { snippetSupport = true } } },
				},
			}),
		})
	end,

	["tsserver"] = function()
		lspconfig.tsserver.setup({
			capabilities = default_options.capabilities,
			flags = default_options.flags,
			on_attach = function(client, bufnr)
				local status_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")

				if not status_ok then
					return
				end

				-- defaults
				ts_utils.setup({
					debug = false,
					disable_commands = false,
					enable_import_on_completion = true,

					-- import all
					import_all_timeout = 5000, -- ms
					import_all_priorities = {
						buffers = 4, -- loaded buffer names
						buffer_content = 3, -- loaded buffer content
						local_files = 2, -- git files or files with relative path markers
						same_file = 1, -- add to existing import statement
					},
					import_all_scan_buffers = 100,
					import_all_select_source = false,

					-- inlay hints
					auto_inlay_hints = true,
					inlay_hints_highlight = "Comment",

					-- update imports on file move
					update_imports_on_move = true,
					require_confirmation_on_move = false,
					watch_dir = nil,

					-- filter diagnostics
					filter_out_diagnostics_by_severity = {},
					filter_out_diagnostics_by_code = {},
				})

				-- required to fix code action ranges and filter diagnostics
				ts_utils.setup_client(client)
				-- no default maps, so you may want to define some here
				local opts = { silent = true }
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>co", ":TSLspOrganize<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>cR", ":TSLspRenameFile<CR>", opts)
			end,
		})
	end,

	["cssls"] = function()
		lspconfig.cssls.setup({
			vim.tbl_deep_extend("force", default_options, {
				capabilities = {
					textDocument = { completion = { completionItem = { snippetSupport = true } } },
				},
			}),
		})
	end,

	["jsonls"] = function()
		lspconfig.jsonls.setup({
			vim.tbl_deep_extend("force", default_options, {
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
			}),
		})
	end,

	["sumneko_lua"] = function()
		lspconfig.sumneko_lua.setup({
			vim.tbl_deep_extend("force", default_options, {
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			}),
		})
	end,

	["eslint"] = function()
		lspconfig.eslint.setup({
			vim.tbl_deep_extend("force", default_options, {
				settings = {
					codeAction = {
						disableRuleComment = {
							enable = true,
							location = "separateLine",
						},
						showDocumentation = {
							enable = true,
						},
					},
					codeActionOnSave = {
						enable = false,
						mode = "all",
					},
					format = true,
					nodePath = "",
					onIgnoredFiles = "off",
					packageManager = "npm",
					quiet = false,
					rulesCustomizations = {},
					run = "onType",
					useESLintClass = false,
					validate = "on",
					workingDirectory = {
						mode = "location",
					},
				},
			}),
		})
	end,
})
