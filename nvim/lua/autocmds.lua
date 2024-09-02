vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
  desc = "Evenly resize windows on screen change",
  group = vim.api.nvim_create_augroup("WindowWatcher", { clear = true }),
  pattern = "*",
})

-- See https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
-- and https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  callback = function()
    vim.o.guicursor = "a:ver25-blinkon1"
    -- Round identations: https://vimtricks.com/p/ensuring-aligned-indentation/
    vim.opt.shiftround = true
  end,
  desc = "Reset the cursor shape on exit",
  group = vim.api.nvim_create_augroup("Cursor", { clear = true }),
  pattern = "*",
})

-- Trim trailing whitespace
local trailing_whitespace_group = vim.api.nvim_create_augroup("TrimTrailingWhiteSpace", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePre",
  { command = "%s/\\s\\+$//e", group = trailing_whitespace_group, pattern = "*" }
)
vim.api.nvim_create_autocmd(
  "BufWritePre",
  { command = "%s/\\n\\+%$//e", group = trailing_whitespace_group, pattern = "*" }
)

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ timeout = 1000 })
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

vim.api.nvim_create_autocmd("CursorMoved", {
  desc = "Remove highlight after moving cursor",
  group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function()
        vim.cmd.nohlsearch()
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Preserve file location before exit",
  callback = function()
    local ignore_ft = { "gitcommit" }
    local ft = vim.bo.filetype
    if vim.tbl_contains(ignore_ft, ft) then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
