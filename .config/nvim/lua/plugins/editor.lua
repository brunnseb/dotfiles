local function is_gp_buffer(buf_nr)
  local content = vim.api.nvim_buf_get_lines(buf_nr, 0, 1, false)
  return string.sub(table.concat(content, "\n"), 0, 8) == "# topic:"
end

return {
  {
    "luukvbaal/nnn.nvim",
    opts = {},
    keys = {
      { "<leader>fn", "<cmd>NnnPicker %:p:h<CR>", desc = "Nnn Picker" },
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
      -- opts.left = opts.left or {}
      -- table.insert(opts.left, {
      --   ft = "oil",
      -- })

      -- opts.top = {
      --   { ft = "nnn", size = { height = 0.2 } },
      -- }
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
      { "<leader>cO", "<cmd>Outline<CR>", "Outline" },
    },
    config = true,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        "neotest-vitest",
      },
    },
  },
  { "metakirby5/codi.vim" },
  { "kevinhwang91/nvim-bqf" },
}
