local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

require("lspconfig").jsonls.setup({
  capabilities = capabilities,
  init_options = {
    provideFormatter = false,
  },
  settings = {
    json = {
      schemas = vim.tbl_extend("keep", {
        {
          fileMatch = { "*.jsonc" },
          schema = {
            allowTrailingCommas = true,
          },
        },
      }, require("schemastore").json.schemas()),
      validate = {
        enable = true,
      },
    },
  },
})
