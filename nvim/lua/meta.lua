-- Metaprogramming things, like scratchpad
local scratchpath = vim.fn.stdpath("config") .. "/lua/scratchpad.lua"

vim.api.nvim_create_user_command("Scratchpad", function()
  vim.cmd("tabedit " .. scratchpath)
  vim.cmd("tcd " .. vim.fn.stdpath("config"))
end, { desc = "Open Scratchpad, a hot-reloading file. Try out ideas here.", nargs = 0 })

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = scratchpath,
  group = vim.api.nvim_create_augroup("Scratchpad", { clear = true }),
  callback = function()
    vim.cmd("source " .. scratchpath)
    vim.notify("Reloaded scratchpad 📝")
  end,
  desc = "Reload Lua files in Neovim config directory on save",
})

vim.api.nvim_create_user_command("Datapath", function()
  vim.cmd("edit " .. vim.fn.stdpath("data"))
  vim.cmd("tcd " .. vim.fn.stdpath("data"))
end, { desc = "Open the datapath for Neovim", nargs = 0 })

-- TODO: command to :lua print([VISUAL SELECTION])
vim.api.nvim_create_user_command("Lua", function(opts)
  local code_to_run
  if opts.range ~= 0 then
    -- Command was called with a range (visual selection or line range)
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getregion(start_pos, end_pos)
    code_to_run = table.concat(lines, "\n")
  else
    -- Command was called without a range
    code_to_run = opts.args
  end

  print("> " .. code_to_run)
  local result = loadstring("return " .. code_to_run)()
  local stringified_result = vim.inspect(result)
  vim.notify("-> " .. stringified_result)
  -- Register 'l' for "Lua"
  vim.fn.setreg("l", result)
end, { desc = "Run some arbitrary Lua code", nargs = "?", range = true })

-- TODO: improve :FileName commpand. Replace pbcopy with Neovim buffers.
--
-- TODO: Neovim's telescope should grep all of help, not just search help tags
--
-- TODO: Syntax highlighting for gitcommit files?
--
--
