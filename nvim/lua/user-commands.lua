local helpers = require("custom-helpers")

local function get_current_path()
  local path = vim.fn.expand("%:.")
  return helpers.removePrefix(path, "oil://")
end

local function openInMacOS()
  if vim.fn.has("mac") ~= 1 then
    vim.notify("This command only works on macOS", vim.log.levels.ERROR)
    return
  end
  vim.fn.system("open " .. get_current_path())
end

vim.api.nvim_create_user_command("Finder", openInMacOS, {})
vim.api.nvim_create_user_command("Open", openInMacOS, {})
vim.api.nvim_create_user_command("FileName", function()
  print(get_current_path() .. " copied to clipboard")
  vim.fn.setreg("+", get_current_path())
end, {})

local ai_buf = nil

local function close_ai_terminal()
  if not ai_buf or not vim.api.nvim_buf_is_valid(ai_buf) then
    return
  end

  local win = vim.fn.bufwinnr(ai_buf)
  if win ~= -1 then
    vim.cmd(win .. "wincmd c")
  end
  vim.api.nvim_buf_delete(ai_buf, { force = true })
  ai_buf = nil
end

local function open_ai_terminal()
  vim.cmd("vsplit")
  vim.cmd("terminal claude")
  ai_buf = vim.api.nvim_get_current_buf()
  vim.cmd("vertical resize " .. math.floor(vim.o.columns / 3))
  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("AI", function()
  if ai_buf and vim.api.nvim_buf_is_valid(ai_buf) then
    close_ai_terminal()
  else
    open_ai_terminal()
  end
end, { desc = "Toggle AI terminal (Claude Code)" })

-- More ergonomic terminal normal mode mapping
vim.keymap.set("t", "<Esc><tab>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Terminal window navigation in insert mode
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to window below" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to window above" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })
