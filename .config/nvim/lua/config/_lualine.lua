local M = {}

function M.setup()
	-- Cobalt Colors
	local colors = {
		red = "#FF6CA4",
		grey = "#7C7F93",
		light_grey = "#BCC0CC",
		black = "#1A3549",
		transparent = "#122432",
		white = "#E2EFFE",
		light_green = "#84DCC6",
		blue = "#006dcc",
		green = "#00C8A0",
		yellow = "#FFD701",
		orange = "#dc8a78",
		cyan = "#90EBED",
	}

	local cobalt = {
		normal = {
			a = { fg = colors.transparent, bg = colors.green, gui = "bold" },
			b = { fg = colors.white, bg = colors.black },
			c = { fg = colors.black, bg = colors.transparent },
			z = { fg = colors.white, bg = colors.black },
		},
		insert = { a = { fg = colors.transparent, bg = colors.blue, gui = "bold" } },
		visual = { a = { fg = colors.transparent, bg = colors.red, gui = "bold" } },
		replace = { a = { fg = colors.black, bg = colors.green, gui = "bold" } },
	}

	local empty = require("lualine.component"):extend()
	function empty:draw(default_highlight)
		self.status = ""
		self.applied_separator = ""
		self:apply_highlights(default_highlight)
		self:apply_section_separators()
		return self.status
	end

	-- Put proper separators and gaps between components in sections
	local function process_sections(sections)
		for name, section in pairs(sections) do
			local left = name:sub(9, 10) < "x"
			for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
				table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.transparent } })
			end
			for id, comp in ipairs(section) do
				if type(comp) ~= "table" then
					comp = { comp }
					section[id] = comp
				end
				comp.separator = left and { right = "" } or { left = "" }
				-- comp.separator = left and { right = '' } or { left = '' }
			end
		end
		return sections
	end

	local function search_result()
		if vim.v.hlsearch == 0 then
			return ""
		end
		local last_search = vim.fn.getreg("/")
		if not last_search or last_search == "" then
			return ""
		end
		local searchcount = vim.fn.searchcount({ maxcount = 9999 })
		return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
	end

	local function modified()
		if vim.bo.modified then
			return "+"
		elseif vim.bo.modifiable == false or vim.bo.readonly == true then
			return "-"
		end
		return ""
	end

	-- vim.g.gitblame_display_virtual_text = 1
	-- local git_blame = require('gitblame')

	require("lualine").setup({
		options = {
			theme = cobalt,
			component_separators = "",
			globalstatus = true,
		},
		-- process_sections
		sections = process_sections({
			lualine_a = { "mode" },
			lualine_b = {
				{ "filename", file_status = false, path = 4 },
				{
					"diagnostics",
					source = { "intelephense", "quick-lint-js" },
					sections = { "error" },
					diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
				},
				{
					"diagnostics",
					source = { "intelephense", "quick-lint-js" },
					sections = { "warn" },
					diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
				},
				{
					"diagnostics",
					source = { "intelephense", "tsserver" },
					sections = { "hint" },
					diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
				},
				{ modified, color = { fg = colors.transparent, bg = colors.yellow } },
			},
			lualine_c = { "aerial" },
			lualine_x = {}, -- { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available  }
			lualine_y = { search_result },
			lualine_z = { "branch" },
		}),
		inactive_sections = {
			lualine_c = { "%f %y %m" },
			lualine_x = {},
		},
	})
end

return M
