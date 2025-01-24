local colors = dofile(vim.g.base46_cache .. "colors")

local options = {
  base46 = {
    theme = "bearded-arc", -- default theme
    hl_add = {},
    hl_override = {
      ["@keyword"] = { italic = true },
      ["@keyword.return"] = { italic = true, bold = true },
      ["@keyword.operator"] = { italic = true },
      ["@keyword.conditional"] = { italic = true },
      ["@tag.attribute"] = { italic = true },
      ["@comment"] = { italic = true },
      ["@punctuation.bracket"] = { bold = true },
      ["DiffviewDiffDelete"] = { link = "Comment" },
    },
    integrations = {
      "diffview",
      "git-conflict",
      "git",
      "lsp",
      "mason",
      "neogit",
      "notify",
      "semantic_tokens",
      "syntax",
      "todo",
      "treesitter",
      "whichkey",
      "trouble",
    },
    changed_themes = {
      ["bearded-arc"] = {
        polish_hl = {
          treesitter = {
            ["@tag.attribute"] = { fg = colors.blue },
          },
        },
      },
    },

    transparency = false,
    theme_toggle = { "onedark", "one_light" },
  },
  ui = {},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
