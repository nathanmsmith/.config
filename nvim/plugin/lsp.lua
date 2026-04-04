vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/pmizio/typescript-tools.nvim",
  "https://github.com/davidosomething/format-ts-errors.nvim",
  "https://github.com/b0o/schemastore.nvim",
})

require("lsp.attach")
require("lsp")
