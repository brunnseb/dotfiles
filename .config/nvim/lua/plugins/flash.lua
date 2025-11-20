-- flash.nvim plugin configuration
-- Provides a quick way to jump to text using flash.nvim
-- Key mappings:
--  <c-space>  - default behavior (disabled here)
--  gm          - trigger flash treesitter incremental selection
--  - actions: m -> next, n -> prev
-- Options: enable search mode.

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
    opts = {
      modes = {
        search = {
          enabled = true,
        },
      },
    },
  },
}
