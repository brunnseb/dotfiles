local M = {}

M.setup = function(plugin, opts)
  require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  require("luasnip.loaders.from_vscode").load { paths = { "/home/brunnseb/.config/astronvim/lua/user/snippets" } } -- load snippets paths
end

return M
