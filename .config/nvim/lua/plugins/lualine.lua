return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(
        opts.sections.lualine_x,
        require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component()
      )
    end,
  },
}
