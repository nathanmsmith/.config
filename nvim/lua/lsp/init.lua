local servers = require("lsp.servers")

-- Installer config
require("mason").setup({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})
require("mason-lspconfig").setup({
  ensure_installed = servers.installable,
})

require("lsp.server_setup")
