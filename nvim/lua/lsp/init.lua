local helpers = require("custom-helpers")
local lsp_installer = require("nvim-lsp-installer")
local servers = require("lsp.servers")

-- Installer config
lsp_installer.setup({
	ensure_installed = servers,
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
	allow_federated_servers = true,
})

-- Non LspInstall server setup
if helpers.isModuleAvailable("stripe") then
	require("stripe").initServers()
else
	require("lsp.server_setup")
end
