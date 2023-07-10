-- autocmds
-- vim.api.nvim_create_autocmd("winleave", {
--   desc = "prevent opening files from telescope in insert mode",
--   -- group = vim.api.nvim_create_augroup("autocomp", { clear = true }),
--   pattern = "*",
--   callback = function()
--     if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
--       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
--     end
--   end,
-- })
--
-- TODO: Check why lspconfig does not work, see https://github.com/olrtg/emmet-language-server/issues/2
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "astro,css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,svelte,typescriptreact,vue",
  callback = function()
    vim.lsp.start {
      cmd = { "emmet-language-server", "--stdio" },
      root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
      init_options = {
        --- @type table<string, any> https://docs.emmet.io/customization/preferences/
        preferences = {},
        --- @type "always" | "never" defaults to `"always"`
        showexpandedabbreviation = "always",
        --- @type boolean defaults to `true`
        showabbreviationsuggestions = true,
        --- @type boolean defaults to `false`
        showsuggestionsassnippets = false,
        --- @type table<string, any> https://docs.emmet.io/customization/syntax-profiles/
        syntaxprofiles = {},
        --- @type table<string, string> https://docs.emmet.io/customization/snippets/#variables
        variables = {},
        --- @type string[]
        excludelanguages = {},
      },
    }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "qf", "lspinfo", "neotest-output", "neotest-output-panel", "spectre_panel" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})

local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true })
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { group = hocon_group, pattern = "*/*.conf", command = "set ft=hocon" }
)

-- Keymaps
vim.cmd "map L $"
vim.cmd "map H ^"

-- Hydras
require("user.config.hydra-nvim").setup()

-- Colorscheme
local links = {
  ["@lsp.type.namespace"] = "@namespace",
  ["@lsp.type.type"] = "@type",
  ["@lsp.type.class"] = "@type",
  ["@lsp.type.enum"] = "@type",
  ["@lsp.type.interface"] = "@type",
  ["@lsp.type.struct"] = "@structure",
  ["@lsp.type.parameter"] = "@parameter",
  ["@lsp.type.variable"] = "@variable",
  ["@lsp.type.property"] = "@property",
  ["@lsp.type.enumMember"] = "@constant",
  ["@lsp.type.function"] = "@function",
  ["@lsp.type.method"] = "@method",
  ["@lsp.type.macro"] = "@macro",
  ["@lsp.type.decorator"] = "@function",
}

for newgroup, oldgroup in pairs(links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end

local rainbow_delimiters = require "rainbow-delimiters"

vim.g.rainbow_delimiters = {
  strategy = {
    [""] = rainbow_delimiters.strategy["global"],
    vim = rainbow_delimiters.strategy["local"],
  },
  query = {
    [""] = "rainbow-delimiters",
    lua = "rainbow-blocks",
    javascript = "rainbow-parens",
    tsx = "rainbow-parens",
  },
  highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
  },
}

-- Vim Multi Cursor Highlights
vim.g.VM_Mono_hl = "MultiCursorMono"
vim.g.VM_Extend_hl = "MultiCursorExtend"
vim.g.VM_Cursor_hl = "MultiCursorCursor"
vim.g.VM_Insert_hl = "MultiCursorInsert"
