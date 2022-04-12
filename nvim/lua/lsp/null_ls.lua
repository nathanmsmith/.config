local null_ls = require("null-ls")

null_ls.setup({
  -- debug = true,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)")
    end
  end,
  sources = {
    -- All
    null_ls.builtins.formatting.trim_whitespace,

    -- Lua
    null_ls.builtins.formatting.stylua,

    -- Go
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.diagnostics.golangci_lint,

    -- Ruby
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.formatting.rubocop.with({
      args = { "--auto-correct-all", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
    }),

    -- JavaScript, etc.
    -- null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.formatting.prettier.with({
    --   only_local = "node_modules/.bin",
    -- }),
  },
})

-- Check for merge conflicts
null_ls.register({
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = {},
  generator = {
    fn = function(params)
      local conflictMarkerBegin = "^<<<<<<< .*$"
      local conflictMarkerCommonAncestors = "^||||||| .*$"
      local conflictMarkerSeparator = "^=======$"
      local conflictMarkerEnd = "^>>>>>>> .*$"
      local conflictMarkers = {
        conflictMarkerBegin,
        conflictMarkerCommonAncestors,
        conflictMarkerSeparator,
        conflictMarkerEnd,
      }

      local diagnostics = {}
      for i, line in ipairs(params.content) do
        for _, marker in ipairs(conflictMarkers) do
          local col, end_col = line:find(marker)
          if col and end_col then
            table.insert(diagnostics, {
              row = i,
              col = col,
              end_col = end_col+1,
              source = "git-conflict-marker",
              message = "Merge conflict marker encountered",
              severity = vim.diagnostic.severity["ERROR"],
            })
          end
        end
      end
      return diagnostics
    end,
  },
})
