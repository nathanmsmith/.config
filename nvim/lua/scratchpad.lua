local scratchpath = vim.fn.stdpath("config") .. "/lua/scratchpad.lua"

-- TODO: add type for _opts
vim.api.nvim_create_user_command("Scratchpad", function(_opts)
  vim.cmd("edit " .. scratchpath)
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

-- TODO: Open GitHub page for Neovim help page
--   P1: Where are the help pages loaded for Neovim?
--       Associate with Neovim GitHub page.
--       open that page on master/main
--
--        if :Blame is used in a help file
--        then -> vim.ui.open("https://github.com/neovim/neovim/blame/master/runtime/doc/diagnostic.txt#L70")
--
--        Future improvement ideas:
--          - handle plugins. can I use the filepath of the absolute path of the help file to determine a git directory?
--            Use git remote?
--            e.g.,
--          --       filepath: /opt/homebrew/Cellar/neovim/0.10.1/share/nvim/runtime/doc/ -> neovim/neovim github link (https://github.com/neovim/neovim/blame/master)
--          --       filepath: ~/.local/share/nvim/lazy/{plugin}/doc/

--
-- TODO: Replace fugitive's :GBrowse with a GitHub blame version.
--
-- TODO: improve :FileName commpand. Replace pbcopy with Neovim buffers.
--
-- TODO: command to open .local/share/nvim/ local dir
--
-- TODO: Neovim's telescope should grep all of help, not just search help tags
--
-- TODO: disable Luacheck line length
--
-- TODO: Syntax highlighting for gitcommit files?
