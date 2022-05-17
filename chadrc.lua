local M = {}

M.plugins = {
   user = require "custom.plugins",
   setup_lspconf = require "custom.plugins.lspconfig",
}

M.ui = {
   theme = "radium",
   colors = "custom.colors",
}

return M
