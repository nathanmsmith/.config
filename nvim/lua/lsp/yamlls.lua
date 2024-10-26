local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

require("lspconfig").yamlls.setup({
  capabilities = capabilities,
  settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    yaml = {
      keyOrdering = false,
      format = {
        enable = false,
      },
      validate = true,
      schemaStore = {
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
})
