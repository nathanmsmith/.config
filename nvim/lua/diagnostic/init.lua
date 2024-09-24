local helpers = require("custom-helpers")

-- Settings
vim.diagnostic.config({
  underline = true,
  float = {
    -- Always show the source of a diagnostic message in the floating window
    source = true,
    border = "single",
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

-- TODO: get these to work with `ghgh`ing into a floating window
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

-- TODO: Implement `:LspLoclist`
vim.api.nvim_create_user_command("LspQuickfix", function(opts)
  -- TODO: handle arguments like `:LspQuickfix Error`, `:LspQuickfix Warn`, `:LspQuickfix Info`, `:LspQuickfix Hint`
  -- Have autocomplete for the arguments
  local severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR }

  -- TODO: fix this type error. Report bug to Neovim core?
  vim.diagnostic.setqflist({ severity = severity })
end, { desc = "", nargs = "?" })

if helpers.isModuleAvailable("stripe") then
  require("stripe").initLinters()
else
  require("diagnostic.linters")
end

vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "TextChangedI" }, {
  desc = "Rerun linters when buffer changes",
  group = vim.api.nvim_create_augroup("Lint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})
