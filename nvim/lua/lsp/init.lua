local helpers = require("custom-helpers")
local servers = require("lsp.servers")

require("fidget").setup()

local installable_servers = servers.installable
if helpers.isModuleAvailable("stripe") then
  installable_servers = {}
end

-- Installer config
require("mason-lspconfig").setup({
  ensure_installed = installable_servers,
})
require("mason-tool-installer").setup({
  ensure_installed = {
    "stylua",
    "prettierd",
  },
})

require("lsp.server_setup")
