local helpers = require("custom-helpers")

if not helpers.isModuleAvailable("stripe") then
  require("lspconfig").ruby_lsp.setup({})
end
