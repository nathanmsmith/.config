require("typescript-tools").setup({
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    tsserver_max_memory = "auto",
    tsserver_locale = "en",
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      if result.diagnostics == nil then
        return
      end

      local format_ts_errors = require("format-ts-errors")
      for _, entry in ipairs(result.diagnostics) do
        local formatter = format_ts_errors[entry.code]
        if formatter then
          entry.message = formatter(entry.message)
        end
      end

      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end,
  },
})
