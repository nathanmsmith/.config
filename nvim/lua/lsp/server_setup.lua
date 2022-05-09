local lspconfig = require("lspconfig")
local servers = require("lsp.servers")
local capabilities = require("lsp.capabilities")
local on_attach = require("lsp.on_attach")

for _, lsp in ipairs(servers.basic) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Advance server setup
require("lsp.lua_server")
require("lsp.sourcekit")
