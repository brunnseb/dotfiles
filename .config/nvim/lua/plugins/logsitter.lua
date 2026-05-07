return {
  {
    "gaelph/logsitter.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      vim.api.nvim_create_augroup("LogSitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = "LogSitter",
        pattern = "javascript,javascriptreact,typescript,typescriptreact,go,lua",
        callback = function()
          vim.keymap.set("n", "glj", function()
            require("logsitter").log()
          end)

          vim.keymap.set("x", "glj", function()
            require("logsitter").log_visual()
          end)

          vim.keymap.set("n", "gld", function()
            require("logsitter").clear_buffer()
          end)

          vim.keymap.set("n", "glD", function()
            require("logsitter").clear_all()
          end)
        end,
      })

      require("logsitter").setup({
        path_format = "default",
        prefix = "[LS] ->",
        separator = "->",
      })
    end,
  },
}
