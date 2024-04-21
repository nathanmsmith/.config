local helpers = require("custom-helpers")

-- Settings
vim.diagnostic.config({
  underline = true,
  float = {
    -- Always show the source of a diagnostic message in the floating window
    source = true,
  },
})

-- Define signs
local signs = {
  Error = ">>",
  Warn = "--",
  Hint = "?",
  Info = "i",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local severity_levels = {
  vim.diagnostic.severity.ERROR,
  vim.diagnostic.severity.WARN,
  vim.diagnostic.severity.INFO,
  vim.diagnostic.severity.HINT,
}

local get_highest_error_severity = function()
  for _, level in ipairs(severity_levels) do
    local diags = vim.diagnostic.get(0, { severity = { min = level } })
    if #diags > 0 then
      return level, diags
    end
  end
end

vim.keymap.set("n", "[w", function()
  vim.diagnostic.goto_prev({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
  })
end)
vim.keymap.set("n", "]w", function()
  vim.diagnostic.goto_next({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
  })
end)

if helpers.isModuleAvailable("stripe") then
  require("stripe").initLinters()
else
  require("diagnostic.linters")
end

local lint_group = vim.api.nvim_create_augroup("Lint", { clear = true })
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  desc = "Rerun linters when buffer changes",
  group = lint_group,
  callback = function()
    require("lint").try_lint()
  end,
})
