local helpers = require("custom-helpers")

if not helpers.isModuleAvailable("stripe") then
  require("formatting.setup")
  local M = {
    enabled = true,
  }

  local format_group = vim.api.nvim_create_augroup("Format", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
      if M.enabled then
        vim.api.nvim_command("FormatWrite")
      end
    end,
    group = format_group,
    pattern = "*",
  })

  M.toggle = function()
    M.enabled = not M.enabled
  end
  M.enable = function()
    M.enabled = true
  end
  M.disable = function()
    M.enabled = false
  end

  vim.api.nvim_create_user_command("FormatToggle", M.toggle, {})
  vim.api.nvim_create_user_command("FormatDisable", M.disable, {})
  vim.api.nvim_create_user_command("FormatEnable", M.enable, {})
end
