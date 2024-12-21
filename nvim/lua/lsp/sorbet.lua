local helpers = require("custom-helpers")

if not helpers.isModuleAvailable("stripe") then
  require("lspconfig").sorbet.setup({
    root_dir = require("lspconfig.util").root_pattern("sorbet/"),
  })
end
