local presets = require "which-key.plugins.presets"
presets.operators["v"] = nil

-- MAPPINGS
local map = nvchad.map

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
-- require("my autocmds file") or just declare them here
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufNewFile", "BufRead" }, {
   pattern = "*.cls,*.trigger",
   command = "set filetype=apexcode",
})
