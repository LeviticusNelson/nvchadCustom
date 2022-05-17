local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local servers = require "nvim-lsp-installer.servers"
local server = require "nvim-lsp-installer.server"
local path = require "nvim-lsp-installer.core.path"
local git = require "nvim-lsp-installer.core.managers.git"

-----------------------------------------------------------
-- Custom Salesforce Apex LSP Installer
-----------------------------------------------------------

local apex_lsp_name = "apex-lsp"

-- Add Apex to LSP Configs
configs[apex_lsp_name] = {
   default_config = {
      filetypes = { "apexcode" },
      root_dir = lspconfig.util.root_pattern "sfdx-project.json",
   },
}

local root_dir = server.get_server_root_path(apex_lsp_name)

local apex_lsp_server = server.Server:new {
   name = apex_lsp_name,
   root_dir = root_dir,
   homepage = "https://developer.salesforce.com/tools/vscode/en/apex/language-server",
   languages = { "apexcode" },
   installer = function(ctx)
      ctx.fs:mkdir "salesforcedx-vscode-git"
      ctx:chdir("salesforcedx-vscode-git", function()
         git.clone { "https://github.com/forcedotcom/salesforcedx-vscode", recursive = true }
      end)
      ctx.fs:rename(
         path.concat {
            "salesforcedx-vscode-git",
            "packages",
            "salesforcedx-vscode-apex",
            "out",
         },
         "out"
      )
      ctx.fs:rmrf "salesforcedx-vscode-git"
   end,
   default_options = {
      cmd = {
         "java",
         "-cp",
         path.concat { root_dir, "out/apex-jorje-lsp.jar" },
         "-Ddebug.internal.errors=true",
         "apex.jorje.lsp.ApexLanguageServerLauncher",
      },
   },
}

servers.register(apex_lsp_server)

-----------------------------------------------------------
-- Load LSP Installer before LSP Config
-----------------------------------------------------------

require("nvim-lsp-installer").setup {}

-----------------------------------------------------------
-- Language Server Configuration
-----------------------------------------------------------
local servers = { "html", "tsserver", "jsonls", "apex-lsp" }

-- Call setup
for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup {
      flags = {
         -- default in neovim 0.7+
         debounce_text_changes = 150,
      },
   }
end
