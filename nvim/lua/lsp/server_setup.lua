local helpers = require("custom-helpers")
local lspconfig = require("lspconfig")
local capabilities = require("lsp.capabilities")
local on_attach = require("lsp.on_attach")

local basic_servers = require("lsp.servers").basic
if helpers.isModuleAvailable("stripe") then
  basic_servers = require("stripe").basicServers()
end

for _, lsp in ipairs(basic_servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Advanced server setup
-- require("lsp.emmet")
require("lsp.lua_server")

-- Non LspInstall server setup
if helpers.isModuleAvailable("stripe") then
  require("stripe").initNullLs()
  require("stripe").initServers()
else
  require("lsp.sourcekit")
  require("lsp.sorbet")
end
