local conform = require("conform")
conform.formatters_by_ft.go = { "goimports", "gofmt" }

if require("custom-helpers").isModuleAvailable("stripe") then
  conform.formatters.goimports = {
    command = vim.env.HOME .. "/stripe/gocode/bin/goimports",
  }
end
