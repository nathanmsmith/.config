-- TODO: marks
-- TODO: skeletons
-- vim.keymap.del("n", "m")

local POSSIBLE_GLOBAL_MARKS = {
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
}

-- Add global mark
vim.keymap.set("n", "ma", function()
  for i, _ in ipairs(POSSIBLE_GLOBAL_MARKS) do
    local potential_next_mark_name = POSSIBLE_GLOBAL_MARKS[i]
    local potential_next_mark = vim.api.nvim_buf_get_mark(0, potential_next_mark_name)
    print(potential_next_mark_name)
    print(vim.inspect(potential_next_mark))

    -- mark will be {0,0} if not in use
    if potential_next_mark[1] == 0 and potential_next_mark[2] == 0 then
      local cursor = vim.api.nvim_win_get_cursor(0)
      local was_mark_set = vim.api.nvim_buf_set_mark(0, potential_next_mark_name, cursor[1], cursor[2], {})
      if was_mark_set then
        vim.notify("Added mark '" .. potential_next_mark_name)
        return
      else
        -- error
      end
    end
  end

  -- TODO: Overwrite mark
end, { desc = "[M]ark [A]dd" })

-- Add local mark
vim.keymap.set("n", "mA", function()
  -- get global marks
end, { desc = "[M]ark [A]dd" })

-- internal.marks = function(opts)
--   local local_marks = {
--     items = vim.fn.getmarklist(opts.bufnr),
--     name_func = function(_, line)
--       return vim.api.nvim_buf_get_lines(opts.bufnr, line - 1, line, false)[1]
--     end,
--   }
--   local global_marks = {
--     items = vim.fn.getmarklist(),
--     name_func = function(mark, _)
--       -- get buffer name if it is opened, otherwise get file name
--       return vim.api.nvim_get_mark(mark, {})[4]
--     end,
--   }
--   local marks_table = {}
--   local marks_others = {}
--   local bufname = vim.api.nvim_buf_get_name(opts.bufnr)
--   for _, cnf in ipairs { local_marks, global_marks } do
--     for _, v in ipairs(cnf.items) do
--       -- strip the first single quote character
--       local mark = string.sub(v.mark, 2, 3)
--       local _, lnum, col, _ = unpack(v.pos)
--       local name = cnf.name_func(mark, lnum)
--       -- same format to :marks command
--       local line = string.format("%s %6d %4d %s", mark, lnum, col - 1, name)
--       local row = {
--         line = line,
--         lnum = lnum,
--         col = col,
--         filename = utils.path_expand(v.file or bufname),
--       }
--       -- non alphanumeric marks goes to last
--       if mark:match "%w" then
--         table.insert(marks_table, row)
--       else
--         table.insert(marks_others, row)
--       end
--     end
--   end
--   marks_table = vim.fn.extend(marks_table, marks_others)-

vim.keymap.set("n", "<Leader>nt", ":tabnew<CR>", {
  noremap = true,
  desc = "Create new tab",
})

-- TODO: customize hovers
-- see
-- 1. https://gist.github.com/OXY2DEV/645c90df32095a8a397735d0be646452
-- 2. https://github.com/neovim/neovim/pull/30935#issuecomment-2449897286

-- TODO: don't save cursor during git mergetool

-- If invoked as a preview callback, performs 'inccommand' preview by
-- highlighting trailing whitespace in the current buffer.
local function trim_space_preview(opts, preview_ns, preview_buf)
  vim.cmd("hi clear Whitespace")
  local line1 = opts.line1
  local line2 = opts.line2
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, line1 - 1, line2, false)
  local preview_buf_line = 0

  for i, line in ipairs(lines) do
    local start_idx, end_idx = string.find(line, "%s+$")

    if start_idx then
      -- Highlight the match
      vim.api.nvim_buf_add_highlight(buf, preview_ns, "Substitute", line1 + i - 2, start_idx - 1, end_idx)

      -- Add lines and set highlights in the preview buffer
      -- if inccommand=split
      if preview_buf then
        local prefix = string.format("|%d| ", line1 + i - 1)

        vim.api.nvim_buf_set_lines(preview_buf, preview_buf_line, preview_buf_line, false, { prefix .. line })
        vim.api.nvim_buf_add_highlight(
          preview_buf,
          preview_ns,
          "Substitute",
          preview_buf_line,
          #prefix + start_idx - 1,
          #prefix + end_idx
        )
        preview_buf_line = preview_buf_line + 1
      end
    end
  end

  -- Return the value of the preview type
  return 2
end

-- Trims all trailing whitespace in the current buffer.
local function trim_space(opts)
  local line1 = opts.line1
  local line2 = opts.line2
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, line1 - 1, line2, false)

  local new_lines = {}
  for i, line in ipairs(lines) do
    new_lines[i] = string.gsub(line, "%s+$", "")
  end
  vim.api.nvim_buf_set_lines(buf, line1 - 1, line2, false, new_lines)
end

-- Create the user command
vim.api.nvim_create_user_command(
  "TrimTrailingWhitespace",
  trim_space,
  { nargs = "?", range = "%", addr = "lines", preview = trim_space_preview }
)
