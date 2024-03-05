local helpers = require("custom-helpers")
local lspconfig = require("lspconfig")

local basic_servers = require("lsp.servers").basic
if helpers.isModuleAvailable("stripe") then
  basic_servers = require("stripe").basicServers()
end

for _, lsp in ipairs(basic_servers) do
  lspconfig[lsp].setup({})
end

-- Advanced server setup
-- require("lsp.emmet")
require("lsp.lua_server")

-- Non LspInstall server setup
if helpers.isModuleAvailable("stripe") then
  require("stripe").initServers()
else
  require("lsp.sourcekit")
  require("lsp.sorbet")
end
