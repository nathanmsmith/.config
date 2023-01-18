local servers = require("lsp.servers")

require("fidget").setup()

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
require("mason-tool-installer").setup({
  ensure_installed = {
    "stylua",
    "prettierd",
  },
})

require("lsp.server_setup")
