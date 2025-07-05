------ MARKS
-- Core ideas:
-- `ma` -> Add a global mark (Start with A and pick first unused mark)
-- `mnX` -> Add a named mark X
-- `mrX` -> Replace the current mark with mark X

-- TODO: `mA` -> Add a local mark (Start with a and pick first unused mark)
-- TODO: `mdc` -> Delete mark on current line
-- `mda` -> Delete all marks globally
-- `mdA` -> Delete all marks locally
-- `ml` -> open list of marks

local M = {}

M.config = {
  signs = {
    enabled = true,
    priority = 100,
    show_uppercase = true,
    show_lowercase = true,
    show_numbered = false,
  },
  sign_group = "MarkGutter",
  sign_name_prefix = "MarkGutter_",
}

-- Initialize the plugin
function M.setup(user_config)
  -- Merge user config with defaults
  if user_config then
    M.config = vim.tbl_deep_extend("force", M.config, user_config)
  end

  -- Define highlight groups
  -- TODO: adjust these
  vim.cmd([[
    highlight default link MarkGutterLower Number
    highlight default link MarkGutterUpper Number
    highlight default link MarkGutterNumbered Number
  ]])

  -- Create signs for lowercase, uppercase, and numbered marks
  if M.config.signs.enabled then
    -- Lowercase marks (a-z)
    if M.config.signs.show_lowercase then
      for i = 97, 122 do -- ASCII codes for a-z
        local char = string.char(i)
        vim.fn.sign_define(M.config.sign_name_prefix .. char, {
          text = char,
          texthl = "MarkGutterLower",
          linehl = "",
          numhl = "",
        })
      end
    end

    -- Uppercase marks (A-Z)
    if M.config.signs.show_uppercase then
      for i = 65, 90 do -- ASCII codes for A-Z
        local char = string.char(i)
        vim.fn.sign_define(M.config.sign_name_prefix .. char, {
          text = char,
          texthl = "MarkGutterUpper",
          linehl = "",
          numhl = "",
        })
      end
    end

    -- Numbered marks (0-9)
    if M.config.signs.show_numbered then
      for i = 48, 57 do -- ASCII codes for 0-9
        local char = string.char(i)
        vim.fn.sign_define(M.config.sign_name_prefix .. char, {
          text = char,
          texthl = "MarkGutterNumbered",
          linehl = "",
          numhl = "",
        })
      end
    end
  end

  -- Set up autocommands to update the signs
  local augroup = vim.api.nvim_create_augroup("MarkGutter", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave", "CmdlineLeave" }, {
    group = augroup,
    callback = function()
      M.update_marks()
    end,
  })

  -- Mark commands can change marks
  vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = augroup,
    pattern = "*",
    callback = function()
      local cmd = vim.fn.getcmdline()
      if cmd:match("^%s*m%s*[a-zA-Z0-9]") then
        vim.schedule(function()
          M.update_marks()
        end)
      end
    end,
  })
end

-- Find next unused global mark (A-Z)
function M.find_next_unused_global_mark()
  local marks = vim.fn.getmarklist()
  local used_marks = {}

  for _, mark in ipairs(marks) do
    local mark_char = mark.mark:sub(2, 2)
    if mark_char:match("[A-Z]") then
      used_marks[mark_char] = true
    end
  end

  for i = 65, 90 do -- ASCII codes for A-Z
    local char = string.char(i)
    if not used_marks[char] then
      return char
    end
  end

  return "A" -- If all marks are used, default to A
end

-- Give all marks (global and local) for a current buffer.
---@param bufnr number Buffer number to get marks for
---@return vim.fn.getmarklist.ret.item[] List of marks where keys are mark names (a-z for local, A-Z for global) and values contain line/column positions
function M.list_all_marks_for_buffer(bufnr)
  local local_marks = vim.fn.getmarklist(bufnr)
  local global_marks = vim.tbl_filter(function(mark)
    -- pos is a 4-tuple with the bufnr, lnum, col, offset. See `:h getmarklist()`.
    local global_mark_bufnr = mark.pos[1]
    return global_mark_bufnr == bufnr
  end, vim.fn.getmarklist())

  return vim.list_extend(local_marks, global_marks)
end

-- Rerender all marks in the sign column
function M.update_marks()
  if not M.config.signs.enabled then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()

  -- Clear all existing marks
  vim.fn.sign_unplace(M.config.sign_group, { buffer = bufnr })

  -- Get all marks
  local all_marks = M.list_all_marks_for_buffer(bufnr)

  -- Place signs for each mark
  for _, mark in ipairs(all_marks) do
    -- Extract the character from 'x
    local mark_char = mark.mark:sub(2, 2)

    local should_show = false
    if M.config.signs.show_lowercase and mark_char:match("[a-z]") then
      should_show = true
    elseif M.config.signs.show_uppercase and mark_char:match("[A-Z]") then
      should_show = true
    elseif M.config.signs.show_numbered and mark_char:match("[0-9]") then
      should_show = true
    end

    if should_show then
      vim.fn.sign_place(0, M.config.sign_group, M.config.sign_name_prefix .. mark_char, bufnr, {
        lnum = mark.pos[2],
        priority = M.config.signs.priority,
      })
    end
  end
end

-- Core ideas:
vim.keymap.set("n", "m-", function()
  local mark = M.find_next_unused_global_mark()
  vim.cmd("normal! m" .. mark)
  M.update_marks()
end, { desc = "Add a mark" })
vim.keymap.set("n", "mda", function()
  vim.cmd("delmarks A-Z")
  M.update_marks()
end, { desc = "Delete all global marks" })

vim.keymap.set("n", "ml", require("fzf-lua").marks, { desc = "List marks" })

M.setup()

return M
