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
