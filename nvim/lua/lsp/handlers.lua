vim.lsp.handlers["workspace/diagnostic/refresh"] = function(err, result, ctx, config)
  vim.notify("refresh")
  local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.diagnostic.reset(ns, bufnr)
  return true
end
