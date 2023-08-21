local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  -- require("stripe").initFormatters()
else
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
