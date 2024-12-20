local options = {

  base46 = {
    theme = "bearded-arc", -- default theme
    hl_add = {},
    hl_override = {},
    integrations = {},
    changed_themes = {},
    transparency = false,
    theme_toggle = { "onedark", "one_light" },
  },
  ui = {},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
