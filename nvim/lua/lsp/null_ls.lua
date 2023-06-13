local helpers = require("custom-helpers")
local null_ls = require("null-ls")
local on_attach = require("lsp.on_attach")

if helpers.isModuleAvailable("stripe") then
  require("stripe").initNullLs()
else
  null_ls.setup({
    debug = true,
    sources = {
      -- Formatters
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.rubocop.with({
        args = { "--autocorrect-all", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
      }),
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,
      null_ls.builtins.formatting.fish_indent,

      -- Linters
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.diagnostics.fish,
      null_ls.builtins.diagnostics.swiftlint,
      null_ls.builtins.diagnostics.rubocop,
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.diagnostics.flake8,
    },
    on_attach = on_attach,
  })
end
