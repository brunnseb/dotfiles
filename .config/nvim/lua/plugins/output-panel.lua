return {
  "mhanberg/output-panel.nvim",
  event = "VeryLazy",
  cmd = { "OutputPanel" },
  keys = {
    { "<leader>uo", "<cmd>OutputPanel<cr>", desc = "Toggle LSP output" },
  },
  config = true,
}
