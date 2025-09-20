return {
  {
    "folke/flash.nvim",
    keys = {
      { "<c-space>", mode = { "n", "o", "x" }, false },
      {
        "gm",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter({
            actions = {
              ["m"] = "next",
              ["n"] = "prev",
            },
          })
        end,
        desc = "Treesitter Incremental Selection",
      },
    },
  },
}
