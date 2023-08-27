local helpers = require("custom-helpers")

if not helpers.isModuleAvailable("stripe") then
  require("formatting.setup")

  local format_group = vim.api.nvim_create_augroup("Format", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
      vim.api.nvim_command("FormatWrite")
    end,
    group = format_group,
    pattern = "*",
  })
end
