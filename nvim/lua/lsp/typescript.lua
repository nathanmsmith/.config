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

      local idx = 1
      while idx <= #result.diagnostics do
        local entry = result.diagnostics[idx]

        local formatter = require("format-ts-errors")[entry.code]
        entry.message = formatter and formatter(entry.message) or entry.message

        -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
        -- Could filter code here
        idx = idx + 1
      end

      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end,
  },
})
