local null_ls = require("null-ls")
local on_attach = require("lsp.on_attach")

null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rubocop.with({
      args = { "--autocorrect-all", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" }
    }),
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.trim_whitespace,
  },
  on_attach = on_attach
})
