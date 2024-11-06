local api = vim.api
local fn = vim.fn

-- State variables
local artist_mode_active = false
local current_tool = "pen" -- Available tools: pen, line, rectangle, fill
local last_pos = { row = 0, col = 0 }

-- Characters used for drawing
local chars = {
  pen = "#",
  line = {
    vertical = "|",
    horizontal = "-",
    corner_tl = "+",
    corner_tr = "+",
    corner_bl = "+",
    corner_br = "+",
    cross = "+",
  },
}

local M = {}

-- Utility functions
local function get_cursor_pos()
  local pos = api.nvim_win_get_cursor(0)
  return { row = pos[1], col = pos[2] }
end

local function set_char_at(row, col, char)
  local line = api.nvim_buf_get_lines(0, row - 1, row, true)[1]
  if #line < col then
    line = line .. string.rep(" ", col - #line)
  end

  local new_line = string.sub(line, 1, col) .. char .. string.sub(line, col + 2)
  api.nvim_buf_set_lines(0, row - 1, row, true, { new_line })
end

local function draw_line(start_row, start_col, end_row, end_col)
  local dx = end_col - start_col
  local dy = end_row - start_row
  local steps = math.max(math.abs(dx), math.abs(dy))

  if steps == 0 then
    set_char_at(start_row, start_col, chars.pen)
    return
  end

  for i = 0, steps do
    local t = i / steps
    local row = math.floor(start_row + dy * t + 0.5)
    local col = math.floor(start_col + dx * t + 0.5)

    if dx == 0 then
      set_char_at(row, col, chars.line.vertical)
    elseif dy == 0 then
      set_char_at(row, col, chars.line.horizontal)
    else
      set_char_at(row, col, chars.pen)
    end
  end
end

local function draw_rectangle(start_row, start_col, end_row, end_col)
  -- Draw corners
  set_char_at(start_row, start_col, chars.line.corner_tl)
  set_char_at(start_row, end_col, chars.line.corner_tr)
  set_char_at(end_row, start_col, chars.line.corner_bl)
  set_char_at(end_row, end_col, chars.line.corner_br)

  -- Draw horizontal lines
  for col = start_col + 1, end_col - 1 do
    set_char_at(start_row, col, chars.line.horizontal)
    set_char_at(end_row, col, chars.line.horizontal)
  end

  -- Draw vertical lines
  for row = start_row + 1, end_row - 1 do
    set_char_at(row, start_col, chars.line.vertical)
    set_char_at(row, end_col, chars.line.vertical)
  end
end

-- Mode functions
function M.toggle_artist_mode()
  artist_mode_active = not artist_mode_active
  if artist_mode_active then
    print("Artist mode enabled")
    -- Enable mouse
    vim.opt_local.mouse = "a"

    -- Set up keymaps
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set("n", "<LeftMouse>", function()
      M.on_mouse_down()
    end, opts)
    vim.keymap.set("n", "<LeftDrag>", function()
      M.on_mouse_drag()
    end, opts)
    vim.keymap.set("n", "<LeftRelease>", function()
      M.on_mouse_release()
    end, opts)
    vim.keymap.set("n", "p", function()
      M.set_tool("pen")
    end, opts)
    vim.keymap.set("n", "l", function()
      M.set_tool("line")
    end, opts)
    vim.keymap.set("n", "r", function()
      M.set_tool("rectangle")
    end, opts)

    -- Disable visual mode mappings for mouse
    vim.keymap.set("n", "<2-LeftMouse>", "<Nop>", opts)
    vim.keymap.set("n", "<3-LeftMouse>", "<Nop>", opts)
    vim.keymap.set("n", "<4-LeftMouse>", "<Nop>", opts)
  else
    print("Artist mode disabled")

    -- Restore mouse settings
    vim.opt_local.mouse = ""

    -- Remove keymaps
    vim.keymap.del("n", "<LeftMouse>", { buffer = true })
    vim.keymap.del("n", "<LeftDrag>", { buffer = true })
    vim.keymap.del("n", "<LeftRelease>", { buffer = true })
    vim.keymap.del("n", "<2-LeftMouse>", { buffer = true })
    vim.keymap.del("n", "<3-LeftMouse>", { buffer = true })
    vim.keymap.del("n", "<4-LeftMouse>", { buffer = true })
    vim.keymap.del("n", "p", { buffer = true })
    vim.keymap.del("n", "l", { buffer = true })
    vim.keymap.del("n", "r", { buffer = true })
  end
end

function M.set_tool(tool)
  if tool ~= current_tool then
    current_tool = tool
    print("Selected tool: " .. tool)
  end
end

function M.on_mouse_drag()
  if not artist_mode_active then
    return
  end

  local curr_pos = get_cursor_pos()

  if current_tool == "pen" then
    set_char_at(curr_pos.row, curr_pos.col, chars.pen)
  end

  last_pos = curr_pos
end

function M.on_mouse_release()
  if not artist_mode_active then
    return
  end

  local curr_pos = get_cursor_pos()

  if current_tool == "line" then
    draw_line(last_pos.row, last_pos.col, curr_pos.row, curr_pos.col)
  elseif current_tool == "rectangle" then
    draw_rectangle(last_pos.row, last_pos.col, curr_pos.row, curr_pos.col)
  end

  last_pos = curr_pos
end

vim.keymap.set("n", "<Leader>a", function()
  M.toggle_artist_mode()
end)
