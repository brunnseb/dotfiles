return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "treesitter")
      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
