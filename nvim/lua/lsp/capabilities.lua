local lsp_status = require("lsp-status")

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

return capabilities
