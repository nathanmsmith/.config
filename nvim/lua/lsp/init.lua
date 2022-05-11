local lsp_installer = require("nvim-lsp-installer")
local servers = require("lsp.servers")

-- Installer config
lsp_installer.setup({
  ensure_installed = servers.installable,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
  allow_federated_servers = true,
})

require("lsp.server_setup")
