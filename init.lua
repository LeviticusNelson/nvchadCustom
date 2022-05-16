-- example file i.e lua/custom/init.lua

-- MAPPINGS
local map = nvchad.map
local presets = require "which-key.plugins.presets"
presets.operators["v"] = nil

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
-- require("my autocmds file") or just declare them here
