local servers = require("lsp.servers")

-- Installer config
require("mason").setup({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})
require("mason-lspconfig").setup({
  ensure_installed = servers.installable,
})

-- Null-ls setup
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.erb_lint,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.swiftformat,
    null_ls.builtins.formatting.black,

    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.trim_whitespace,
  },
})

require("lsp.server_setup")
