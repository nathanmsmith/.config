local capabilities = require("lsp.capabilities")
local on_attach = require("lsp.on_attach")

require("lspconfig").sourcekit.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "xcrun", "sourcekit-lsp" },
})
