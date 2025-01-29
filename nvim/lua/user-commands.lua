vim.api.nvim_create_user_command("Finder", function()
  -- TODO
  -- if filetype == oil then
  --   process
  --   end
  if vim.fn.has("mac") ~= 1 then
    vim.notify("This command only works on macOS", vim.log.levels.ERROR)
    return
  end
  vim.fn.system("open " .. vim.fn.expand("%:p"))
end, { bang = true })
vim.api.nvim_create_user_command("FileName", function()
  local name_and_path = vim.fn.expand("%")
  vim.fn.setreg("+", name_and_path)
end, { bang = true })
