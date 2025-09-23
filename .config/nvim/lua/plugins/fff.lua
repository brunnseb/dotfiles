return {
  {
    "madmaxieee/fff.nvim",
    build = "cargo build --release",
    -- if you are using nixos
    -- build = "nix run .#release",
    opts = { -- (optional)
      debug = {
        enabled = true, -- we expect your collaboration at least during the beta
        show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
      },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
    keys = {
      {
        "<leader>ff",
        "<cmd>FFFSnacks<CR>",
        desc = "FFFind files",
      },
    },
  },
}
