local M = {}

M.ui = {
   theme = "cobalt2",
}

M.plugins = {
   user = require "custom.plugins",
   options = {
     lspconfig = {
       setup_lspconf = "custom.plugins.lsp"
     }
   }
}

M.mappings = require "custom.mappings"
return M
