-- Auto-reload buffers when files change externally (e.g., edited by Claude Code)

-- Enable automatic file reading when changed outside Neovim
vim.opt.autoread = true

-- Auto-reload files when focus is gained or buffer is entered
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})

-- Notify when file is changed outside Neovim
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})
