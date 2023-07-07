return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    matchup = {
      enable = true,
    },
    ensure_installed = {
      "awk",
      "bibtex",
      "bash",
      "c",
      "comment",
      "css",
      "diff",
      "dockerfile",
      "fish",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "graphql",
      "hocon",
      "html",
      "http",
      "ini",
      "javascript",
      "jq",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "latex",
      "lua",
      "luadoc",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "norg",
      "nix",
      "org",
      "python",
      "query",
      "rasi",
      "regex",
      "rust",
      "scss",
      "sql",
      "svelte",
      "toml",
      "tsx",
      "typescript",
      "vue",
      "yaml",
      "yuck",
    },
  },
  dependencies = {
    { "nvim-treesitter/playground" },
    { "andymass/vim-matchup" },
    {
      "HiPhish/nvim-ts-rainbow2",
      config = function()
        require("nvim-treesitter.configs").setup {
          rainbow = {
            enable = true,
            -- Which query to use for finding delimiters
            query = "rainbow-parens",
            -- Highlight the entire buffer all at once
            strategy = require "ts-rainbow.strategy.global",
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gm",
              node_incremental = "m",
              scope_incremental = "M",
              node_decremental = "n",
            },
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "markdown" },
          },
        }
      end,
    },
  },
}
