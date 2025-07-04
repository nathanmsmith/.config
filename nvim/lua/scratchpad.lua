vim.api.nvim_create_user_command("ReloadConfig", function()
  -- Source the init.lua file
  dofile(vim.env.MYVIMRC)

  -- Notify the user
  vim.notify("Neovim configuration reloaded!", vim.log.levels.INFO)
end, {})
