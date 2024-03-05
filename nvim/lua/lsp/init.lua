local helpers = require("custom-helpers")
local servers = require("lsp.servers")

local installable_servers = servers.installable
local installable_tools = servers.tools
if helpers.isModuleAvailable("stripe") then
  installable_servers = require("stripe").installableServers()
  installable_tools = require("stripe").installableTools()
end

-- Installer config
require("mason-lspconfig").setup({
  ensure_installed = installable_servers,
})
require("mason-tool-installer").setup({
  ensure_installed = installable_tools,
})

require("lsp.server_setup")
