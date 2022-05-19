local M = {}

M.plugins = {
   user = require "custom.plugins",
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
}

M.ui = {
   theme = "radium",
   colors = "custom.colors",
}

return M
