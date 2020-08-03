local lsp_status = require('lsp-status')
lsp_status.register_progress()
lsp_status.config({
  status_symbol = ''
})

local nvim_lsp = require('nvim_lsp')

nvim_lsp.clangd.setup({
  callbacks = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true
  },
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
})
nvim_lsp.pyls.setup{
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.vimls.setup{
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
}
