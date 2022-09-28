local M = {}

function M.setup()
	local status_ok, cmp = pcall(require, "cmp")
	if not status_ok then
		return
	end

	local snip_status_ok, luasnip = pcall(require, "luasnip")
	if not snip_status_ok then
		print("not ok")
		return
	end

	require("luasnip/loaders/from_vscode").lazy_load()

	-- Utils
	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim-lua" },
			{ name = "luasnip" },
		}, {
			{ name = "fuzzy_buffer" },
		}),
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<C-l>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<C-h>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		}),
	})

	cmp.setup.cmdline("/", {
		sources = cmp.config.sources({
			{ name = "fuzzy_buffer" },
		}),
		mapping = cmp.mapping.preset.cmdline(),
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "fuzzy_path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

return M
