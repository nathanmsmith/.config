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
  -- An argument was given
  -- TODO: make this check more robust
  if opts.args ~= "" then
    code_to_run = opts.args
  else
    -- Assume a range was given.
    -- TODO: handle multiple lines
    code_to_run = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)[1]
  end

  print("Running: " .. code_to_run)
  local result = loadstring("return " .. code_to_run)()
  -- TODO: handle nil values
  local stringified_result = tostring(result)
  vim.notify(stringified_result)
  -- Register 'l' for "Lua"
  vim.fn.setreg("l", result)
end, { desc = "Run some arbitrary Lua code", nargs = "?", range = 2 })
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
