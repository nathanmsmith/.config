local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

print("nathan jsonls loaded")
require("lspconfig").jsonls.setup({
  capabilities = capabilities,
  init_options = {
    provideFormatter = false,
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      print(vim.inspect(err))
      print(vim.inspect(result))
      print(vim.inspect(ctx))
      print(vim.inspect(config))
      -- if string.match(result.uri, "%.json5$", -6) and result.diagnostics ~= nil then
      --   local idx = 1
      --   while idx <= #result.diagnostics do
      --     -- "Comments are not permitted in JSON."
      --     if result.diagnostics[idx].code == 521 then
      --       table.remove(result.diagnostics, idx)
      --     else
      --       idx = idx + 1
      --     end
      --   end
      -- end
      vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
    end,
  },
})
