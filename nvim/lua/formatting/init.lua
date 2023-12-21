local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  require("stripe").initFormatters()
else
  -- Common formatters
  local prettier = { { "prettierd", "prettier" } }

  require("conform").setup({
    log_level = vim.log.levels.INFO,
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
      swift = { "swiftformat" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })
end

-- Commands to enable/disable formatting
-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
