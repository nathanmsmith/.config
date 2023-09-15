local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  -- TODO: load stripe formatting config
else
  -- Common formatters
  local prettier = { { "prettierd", "prettier" } }

  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      ruby = { "rubocop" },
      javascript = prettier,
      typescript = prettier,
      javascriptreact = prettier,
      typescriptreact = prettier,
      html = prettier,
      json = prettier,
      jsonc = prettier,
      graphql = prettier,
      go = { "goimports", "gofmt" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })
end
