local function is_gp_buffer(buf_nr)
  local content = vim.api.nvim_buf_get_lines(buf_nr, 0, 1, false)
  return string.sub(table.concat(content, "\n"), 0, 8) == "# topic:"
end

return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<CR>", desc = "Diffview Open" },
      { "<leader>gdd", "<cmd>DiffviewOpen origin/develop..HEAD<CR>", desc = "Diffview Open (develop)" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview File History" },
      { "<leader>gdH", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview File History (File)" },
    },
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "BufReadPre",
    config = function()
      local function h(name)
        return vim.api.nvim_get_hl(0, { name = name })
      end

      -- hl-groups can have any name
      vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })

      local function text_format(symbol)
        local res = {}

        local round_start = { "", "SymbolUsageRounding" }
        local round_end = { "", "SymbolUsageRounding" }

        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          table.insert(res, round_start)
          table.insert(res, { "󰌹 ", "SymbolUsageRef" })
          table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.definition then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, round_start)
          table.insert(res, { "󰳽 ", "SymbolUsageDef" })
          table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.implementation then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, round_start)
          table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
          table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        return res
      end

      require("symbol-usage").setup({
        text_format = text_format,
      })
    end,
  },
  {
    "dnlhc/glance.nvim",
    config = true,
    keys = {
      { "gr", "<cmd>Glance references<CR>", "Goto references" },
      { "gy", "<cmd>Glance type_definitions<CR>", "Goto T[y]pe" },
      { "gd", "<cmd>Glance definitions<CR>", "Goto definition" },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      { "S", mode = { "x", "o" }, false },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        custom_filter = function(buf_number)
          return is_gp_buffer(buf_number) ~= true
        end,
      },
    },
  },
  {
    "uga-rosa/translate.nvim",
    cmd = { "Translate" },
    opts = {
      default = {
        output = "replace",
        parse_before = "concat,trim,natural",
      },
    },
  },
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.right = {
        { ft = "Fm" },
        {
          ft = "markdown",
          -- pinned = true,
          title = "ChatGPT",
          size = { width = 0.25 },
          filter = function(buf)
            return is_gp_buffer(buf)
          end,
          -- open = "GpChatToggle",
        },
        { ft = "Outline", pinned = true, open = "Outline" },
      }
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {
      patterns = { ".git", ".neoconf.json" },
      detection_methods = { "pattern" },
    },
  },
  {
    "silvercircle/outline.nvim",
    cmd = { "Outline" },
    keys = {
      { "<leader>co", "<cmd>Outline<CR>", "Outline" },
    },
    config = true,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", --
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        "neotest-vitest",
      },
    },
  },
  { "metakirby5/codi.vim", cmd = { "Codi", "CodiNew", "CodiUpdate", "CodiExpand", "CodiSelect" } },
}
