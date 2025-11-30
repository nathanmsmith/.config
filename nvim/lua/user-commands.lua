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

local function open_ai_terminal(program)
  program = program or "claude"
  if helpers.isModuleAvailable("stripe") then
    program = require("stripe").aiCommand()
  end

  local current_file = vim.fn.expand("%:p")
  local cmd = program
  if current_file ~= "" then
    cmd = program .. " " .. vim.fn.shellescape(current_file)
  end

  vim.cmd("vsplit")
  vim.cmd("terminal " .. cmd)
  ai_buf = vim.api.nvim_get_current_buf()
  vim.cmd("vertical resize " .. math.floor(vim.o.columns / 3))
  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("AI", function(opts)
  if ai_buf and vim.api.nvim_buf_is_valid(ai_buf) then
    close_ai_terminal()
  else
    open_ai_terminal(opts.args ~= "" and opts.args or nil)
  end
end, { desc = "Toggle AI terminal (Claude Code)", nargs = "?" })

vim.api.nvim_create_user_command("Devlog", function(opts)
  local devlog_dir = vim.fn.expand("~/Developer/devlog")
  local filename = opts.args ~= "" and opts.args or os.date("%Y-%m-%d") .. ".md"

  -- Ensure filename has .md extension
  if not filename:match("%.md$") then
    filename = filename .. ".md"
  end

  local filepath = devlog_dir .. "/" .. filename
  vim.cmd("edit " .. vim.fn.fnameescape(filepath))
end, { desc = "Open devlog file", nargs = "?" })

-- More ergonomic terminal normal mode mapping
vim.keymap.set("t", "<Esc><tab>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Terminal window navigation in insert mode
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to window below" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to window above" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })
