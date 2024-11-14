vim.api.nvim_create_user_command("Finder", '!open "%:p:h"', { bang = true })
vim.api.nvim_create_user_command("FileName", function()
  -- vim.b.
  -- TODO: get file name in Lua ("%")
  -- vim.fn.setreg("*", "@%")
end, { bang = true })
