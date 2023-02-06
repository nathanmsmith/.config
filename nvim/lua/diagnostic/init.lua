-- Settings
-- vim.diagnostic.config({
--   virtual_text = true,
--   signs = true,
--   underline = true,
--   update_in_insert = false,
-- })

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

-- Keymaps
vim.keymap.set("n", "[w", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]w", vim.diagnostic.goto_next)

-- Setup Trouble for project navigation
require("trouble").setup({
  icons = false,
  use_diagnostic_signs = true,
})

local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  require("stripe").initLinters()
else
  require("diagnostic.linters")
end

local lint_group = vim.api.nvim_create_augroup("Lint", { clear = true })
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  callback = function()
    require("lint").try_lint()
  end,
  group = lint_group,
})
