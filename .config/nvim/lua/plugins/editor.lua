local function is_gp_buffer(buf_nr)
  local content = vim.api.nvim_buf_get_lines(buf_nr, 0, 1, false)
  return string.sub(table.concat(content, "\n"), 0, 8) == "# topic:"
end

return {
  { "akinsho/git-conflict.nvim", version = "*", config = true },
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
    "folke/flash.nvim",
    keys = {
      { "S", mode = { "x", "o" }, false },
      {
        "tsn",
        mode = { "x", "o", "n" },
        function()
          require("flash").jump({
            search = { wrap = false, mult_window = false, forward = true, mode = "search", max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = "^",
          })
        end,
      },
      {
        "tse",
        mode = { "x", "o", "n" },
        function()
          require("flash").jump({
            search = { wrap = false, mult_window = false, forward = false, mode = "search", max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = "^",
          })
        end,
      },
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
    enable = false,
    keys = {
      ["<c-up>"] = false,
      ["<c-down>"] = false,
      ["<c-w>+"] = false,
      -- decrease height
      ["<c-w>-"] = false,
    },
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
}
