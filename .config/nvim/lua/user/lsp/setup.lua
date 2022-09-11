local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')

if not mason_ok or not mason_lsp_ok then	
  return
end


mason.setup {
  ui = {
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
  }
}

mason_lsp.setup {
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = { "bash-language-server", "css-lsp", "cssmodules-language-server", "eslint-lsp", "graphql-language-service-cli", "html-lsp",
    "json-lsp", "lua-language-server", "tailwindcss-language-server", "typescript-language-server",
    "firefox-debug-adapter", "node-debug2-adapter", "svelte-language-server", "sumneko_lua" },

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the, "svelte-language-server" ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = true,
}

local lspconfig = require('lspconfig')
local default = require('user.lsp.servers.default')

local servers = {'tsserver', 'tailwindcss', 'sumneko_lua', 'jsonls', 'cssls', 'cssmodules_ls' }

for _, v in pairs(servers) do
  lspconfig[v].setup(require('user.lsp.servers.' .. v))
end

