local helpers = require("custom-helpers")
local lspconfig = require("lspconfig")
local servers = require("lsp.servers")
local capabilities = require("lsp.capabilities")
local on_attach = require("lsp.on_attach")

for _, lsp in ipairs(servers.basic) do
  if helpers.isModuleAvailable("stripe") and lsp == "tailwindcss" then
    -- do nothing
  else
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
end

-- Advance server setup
-- require("lsp.emmet")
require("lsp.lua_server")

-- Non LspInstall server setup
if helpers.isModuleAvailable("stripe") then
  require("stripe").initServers()
else
  require("lsp.sourcekit")
  require("lsp.sorbet")
  require("lsp.null_ls")
end
