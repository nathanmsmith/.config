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

local ai_buf = nil

vim.api.nvim_create_user_command("AI", function()
  if ai_buf and vim.api.nvim_buf_is_valid(ai_buf) then
    local win = vim.fn.bufwinnr(ai_buf)
    if win ~= -1 then
      -- AI window exists, close it
      vim.cmd(win .. "wincmd c")
      ai_buf = nil
    else
      -- AI buffer exists but not visible, show it
      vim.cmd("vsplit")
      vim.api.nvim_set_current_buf(ai_buf)
      vim.cmd("vertical resize " .. math.floor(vim.o.columns / 3))
      vim.cmd("startinsert")
    end
  else
    -- No AI buffer, create new one
    vim.cmd("vsplit")
    vim.cmd("terminal claude")
    ai_buf = vim.api.nvim_get_current_buf()
    vim.cmd("vertical resize " .. math.floor(vim.o.columns / 3))
    vim.cmd("startinsert")
  end
end, {})

-- More ergonomic terminal normal mode mapping
vim.keymap.set("t", "<Esc><tab>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Terminal window navigation in insert mode
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to window below" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to window above" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })
