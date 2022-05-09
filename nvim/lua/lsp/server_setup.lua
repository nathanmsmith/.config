local lspconfig = require("lspconfig")
local lspconfig = require("lspconfig")
local servers = require("lsp.servers")
local capabilities = require("lsp.capabilities")
local on_attach = require("lsp.on_attach")

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
