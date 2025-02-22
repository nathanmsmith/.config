local helpers = require("custom-helpers")

local function openInMacOS()
  if vim.fn.has("mac") ~= 1 then
    vim.notify("This command only works on macOS", vim.log.levels.ERROR)
    return
  end

  local path = vim.fn.expand("%:p")
  path = helpers.removePrefix(path, "oil://")

  vim.fn.system("open " .. path)
end

vim.api.nvim_create_user_command("Finder", openInMacOS, {
  -- TODO: a bang version that copies the path to clipboard
  -- bang = true,
})
vim.api.nvim_create_user_command("Open", openInMacOS, {})
vim.api.nvim_create_user_command("FileName", function()
  local path = vim.fn.expand("%:p")
  path = helpers.removePrefix(path, "oil://")
  vim.fn.setreg("+", path)
end, { bang = true })
