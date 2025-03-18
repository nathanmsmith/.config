-- Stolen from TheLeoP's config. 3/17/2025.
-- https://github.com/TheLeoP/nvim-config/blob/master/plugin/abolish.lua
-- https://github.com/TheLeoP/nvim-config/blob/master/lua/personal/abolish.lua
--
-- Which was in turn ported from https://github.com/tpope/vim-abolish

local api = vim.api

local M = {}

M.char = ""

---@return 'g@'|nil
function M.coerce()
  local needs_help_msg = true
  vim.defer_fn(function()
    if not needs_help_msg then
      return
    end

    local separator = { " | ", "WarningMsg" }
    --stylua: ignore
    api.nvim_echo({
      {"Enter coerce identifier (single character): "},
      {"c", "Question"}, {": camelcase"},
      separator,
      {"["},{"m", "Question"},{","},{"p", "Question"},{"]"}, {": mixedcase"},
      separator,
      {"["},{"s", "Question"},{","},{"_", "Question"},{"]"}, {": snakecase"},
      separator,
      {"["},{"u", "Question"},{","},{"U", "Question"},{"]"}, {": uppercase"},
      separator,
      {"["},{"-", "Question"},{","},{"k", "Question"},{"]"}, {": dashcase"},
      separator,
      {".", "Question"}, {": dotcase"},
      separator,
      {"<space>", "Question"}, {": spacecase"},
    }, false, {})
  end, 1000)

  local ok, char = pcall(vim.fn.getcharstr)
  needs_help_msg = false

  vim.cmd([[echo '' | redraw]])

  if not ok or char == "\27" then
    return
  end
  M.char = char

  vim.o.operatorfunc = "v:lua.require'abolish'.coerce_operatorfunc"
  return "g@"
end

---@param type "line"|"char"|"block"
function M.coerce_operatorfunc(type)
  local cursor_location = api.nvim_win_get_cursor(0)
  local count = vim.v.count1 ---@type integer
  while count > 0 do
    count = count - 1

    local start_row, start_col = unpack(api.nvim_buf_get_mark(0, "[")) ---@type integer, integer
    local end_row, end_col = unpack(api.nvim_buf_get_mark(0, "]")) ---@type integer, integer

    local coercion = M.coercions[M.char]
    if not coercion then
      vim.notify(("There is no coercion for char %s"):format(M.char), vim.log.levels.Warning)
      return
    end

    if type == "line" then
      local lines = api.nvim_buf_get_lines(0, start_row - 1, end_row, true)
      for i, line in ipairs(lines) do
        local coerced_line = coercion(line)
        if line ~= coerced_line then
          api.nvim_buf_set_lines(0, start_row - 1 + i - 1, start_row - 1 + i, true, { coerced_line })
        end
      end
    elseif type == "block" then
      local lines = api.nvim_buf_get_lines(0, start_row - 1, end_row, true)
      for i, line in ipairs(lines) do
        local text = line:sub(start_col + 1, end_col + 1)
        local coerced_text = coercion(text)
        if text ~= coerced_text then
          api.nvim_buf_set_text(
            0,
            start_row - 1 + i - 1,
            start_col,
            start_row - 1 + i - 1,
            end_col + 1,
            { coerced_text }
          )
        end
      end
    else
      local lines = api.nvim_buf_get_text(0, start_row - 1, start_col, end_row - 1, end_col + 1, {})
      local text = table.concat(lines, "\n")
      local coerced_text = coercion(text)
      if text ~= coerced_text then
        api.nvim_buf_set_text(
          0,
          start_row - 1,
          start_col,
          end_row - 1,
          end_col + 1,
          vim.split(coerced_text, "\n", { trimempty = true })
        )
      end
    end
  end
  api.nvim_win_set_cursor(0, cursor_location)
end

---@type table<string, string>
local abolish_last_dict

---@class abolish.command_opts
---@field name string Command name
---@field args string The args passed to the command, if any
---@field fargs string[] The args split by unescaped whitespace (when more than one argument is allowed), if any
---@field nargs number Number of arguments
---@field bang boolean "true" if the command was executed with a ! modifier
---@field line1 number The starting line of the command range
---@field line2 number The final line of the command range
---@field range number The number of items in the command range: 0, 1, or 2
---@field count number Any count supplied
---@field reg string The optional register, if specified
---@field mods string Command modifiers, if any
---@field smods string[] Command modifiers in a structured format. Has the same structure as the "mods" key of nvim_parse_cmd()

---@param flags string|table<string, any>
local function normalize_options(flags)
  ---@type table<string, any>, string
  local opts
  if type(flags) == "table" then
    opts = flags
    flags = flags.flags --[[@as string]]
  else
    opts = {}
  end

  if flags:match("w") then
    opts.boundaries = 2
  elseif flags:match("v") then
    opts.boundaries = 1
  elseif not opts.boundaries then
    opts.boundaries = 0
  end

  opts.case = opts.case or true
  opts.case = not flags:match("I") and opts.case or false
  opts.flags = flags:gsub("[Iivw]", "")
  return opts
end

---@param p abolish.parsed_input
local function expand_braces(p)
  local out = {} ---@type table<string, string>
  local str = p.string or { before = "", fragments = {}, after = "" }

  local total = math.max(#p.pattern.fragments, #str.fragments)

  if total == 0 then
    out[p.pattern.before .. p.pattern.after] = str.before .. str.after
    return out
  end

  for i = 1, total do
    out[p.pattern.before .. p.pattern.fragments[i] .. p.pattern.after] = str.before .. str.fragments[i] .. str.after
  end
  return out
end

---@param word string
---@return string
function M.camelcase(word)
  word = word:gsub("%-", "_")
  if not word:match("_") and word:match("%l") then
    return word:sub(1, 1):lower() .. word:sub(2)
  else
    word = word:gsub("(_?)(.)", function(maybe_underscore, any)
      if maybe_underscore == "" then
        return any:lower()
      else
        return any:upper()
      end
    end)
    return word
  end
end

--PascalCase
---@param word string
---@return string
function M.mixedcase(word)
  local camelcase = M.camelcase(word)
  return camelcase:sub(1, 1):upper() .. camelcase:sub(2)
end

---@param word string
---@return string
function M.snakecase(word)
  word = word:gsub("(%u+)(%u%l)", "%1_%2")
  word = word:gsub("([%l%d])(%u)", "%1_%2")
  word = word:gsub("[.%-]", "_")
  word = word:lower()
  return word
end

---@param word string
---@return string
function M.uppercase(word)
  return M.snakecase(word):upper()
end

---@param word string
---@return string
function M.dashcase(word)
  local dashcase = M.snakecase(word):gsub("_", "-")
  return dashcase
end

---@param word string
---@return string
function M.spacecase(word)
  local spacecase = M.snakecase(word):gsub("_", " ")
  return spacecase
end

---@param word string
---@return string
function M.dotcase(word)
  local dotcase = M.snakecase(word):gsub("_", ".")
  return dotcase
end

---returs {[""]= ""} when there is no pattern yet
---@param parsed abolish.parsed_input
---@param opts table<string, any>
---@return table<string, string> dict key: lhs of substitution, value: rhs of substitution
local function create_dictionary(parsed, opts)
  ---@type table<string, string>
  local dict = {}
  local expanded = expand_braces(parsed)

  local case = true
  if opts.case ~= nil then
    case = opts.case
  end
  for lhs, rhs in pairs(expanded) do
    if case then
      dict[M.mixedcase(lhs)] = M.mixedcase(rhs)
      dict[lhs:lower()] = rhs:lower()
      dict[lhs:upper()] = rhs:upper()
    end
    dict[lhs] = rhs
  end

  return dict
end

---@param a string
---@param b string
local function sort(a, b)
  local a_lower = a:lower()
  local b_lower = b:lower()
  if a_lower == b_lower then
    if a == b then
      return true
    elseif a > b then
      return false
    else
      return true
    end
  elseif #a == #b then
    return a_lower < b_lower
  else
    return #a > #b
  end
end

---@param pattern string
---@return string
local function subesc(pattern)
  return vim.fn.substitute(pattern, [=[[][\\/.*+?~%()&]]=], [[\\&]], "g")
end

---@param dict table<string, string>
---@param boundaries number
local function pattern(dict, boundaries)
  local a, b ---@type string, string
  if boundaries == 2 then
    a = "<"
    b = ">"
  elseif boundaries == 1 then
    a = "%(<|_@<=|[[:lower:]]@<=[[:upper:]]@=)"
    b = "%(>|_@=|[[:lower:]]@<=[[:upper:]]@=)"
  else
    a = ""
    b = ""
  end
  local keys = vim.tbl_keys(dict)
  table.sort(keys, sort)
  return [[\v\C]] .. a .. "%(" .. vim.iter(keys):map(subesc):join("|") .. ")" .. b
end

function M.abolished()
  local submatch = vim.fn.submatch(0)
  return abolish_last_dict[submatch] or submatch
end

---@type table<string, {col:integer, row: integer}[]>
local already_seen = {}

M.skip_start = function()
  local row, col = unpack(api.nvim_win_get_cursor(0))
  local id = ("%d,%d"):format(row, col)
  if already_seen.start[id] then
    return true
  end
  already_seen.start[id] = {
    row = row,
    col = col,
  }
  return false
end

M.skip_end = function()
  local row, col = unpack(api.nvim_win_get_cursor(0))
  local id = ("%d,%d"):format(row, col)
  if already_seen.end_[id] then
    return true
  end
  already_seen.end_[("%d,%d"):format(row, col)] = {
    row = row,
    col = col,
  }
  return false
end

---@param buf integer
---@param preview_ns integer
---@param stop_line integer
---@param search string
---@param opts {backward: boolean}
local function highlight_search(buf, preview_ns, stop_line, search, opts)
  local s_flags = opts.backward and "bnc" or "nc"
  local e_flags = opts.backward and "bnce" or "nce"
  while true do
    ---@type integer, integer
    local s_row, s_col =
      unpack(vim.fn.searchpos(search, s_flags, stop_line, nil, "v:lua.require'abolish'.skip_start()"))
    if s_row == 0 then
      break
    end
    s_row = s_row - 1
    s_col = s_col - 1
    ---@type integer, integer
    local e_row, e_col = unpack(vim.fn.searchpos(search, e_flags, stop_line, nil, "v:lua.require'abolish'.skip_end()"))
    if e_row == 0 then
      break
    end
    e_row = e_row - 1
    api.nvim_buf_set_extmark(buf, preview_ns, s_row, s_col, {
      end_row = e_row,
      end_col = e_col,
      hl_group = "Search",
    })
  end
end

---@param count integer
---@param line1 integer
---@param line2 integer
---@param parsed abolish.parsed_input
---@param preview_ns integer|nil
local function substitute_command(count, line1, line2, parsed, preview_ns)
  local opts = normalize_options(parsed.flags or "")
  local dict = create_dictionary(parsed, opts)
  local lhs = pattern(dict, opts.boundaries)

  if not preview_ns or (preview_ns and parsed.string) then
    local cmd = {}
    if count then
      cmd.range = { line1, line2 }
    end

    abolish_last_dict = dict

    cmd.args = {
      table.concat({
        "/",
        lhs,
        [[/\=luaeval("require'abolish'.abolished()")]],
        "/",
        opts.flags,
      }),
    }
    vim.cmd.substitute(cmd)
  elseif preview_ns and #vim.tbl_keys(dict) > 1 then
    already_seen.start = {}
    already_seen.end_ = {}

    local buf = api.nvim_get_current_buf()
    local stop_line = math.min(vim.fn.line("w$"), line2)
    highlight_search(buf, preview_ns, stop_line, lhs, { backward = false })

    stop_line = math.max(vim.fn.line("w0"), line1)
    highlight_search(buf, preview_ns, stop_line, lhs, { backward = true })
  end
end

---@param preview_ns integer|nil
---@param line1 number
---@param line2 number
---@param count number
---@param parsed abolish.parsed_input
local function parse_substitute(preview_ns, line1, line2, count, parsed)
  if not parsed.pattern and not parsed.string and not preview_ns then
    return vim.notify("Argument required", vim.log.levels.ERROR)
  end

  substitute_command(count, line1, line2, parsed, preview_ns)
end

---@param parsed abolish.parsed_input
local find_command = function(parsed)
  local opts = normalize_options(parsed.flags or "")
  local dict = create_dictionary(parsed, opts)
  local cmd = parsed.separator == "?" and "?" or "/"

  local search = pattern(dict, opts.boundaries)
  vim.fn.setreg("/", search)

  if opts.flags == "" or vim.fn.search(vim.fn.getreg("/"), "n") == 0 then
    local args = table.concat({ cmd, "\n" })
    vim.cmd.normal({ args, bang = true })
  else
    local args = table.concat({ cmd .. cmd .. opts.flags .. "\n" })
    vim.cmd.normal({ args, bang = true })
    vim.fn.histdel("search", -1)
  end
end

local DO_NOT_PREVIEW = 0
local PREVIEW_IN_CURRENT_BUFFER = 1

---@return string[]
local function get_words()
  ---@type string[]
  local words = {}
  local lnum = vim.fn.line("w0")
  while lnum <= vim.fn.line("w$") do
    local line = api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1]
    local col = 0
    while vim.fn.match(line, [[\<\k\k\+\>]], col) ~= -1 do
      table.insert(words, vim.fn.matchstr(line, [[\<\k\k\+\>]], col))
      col = vim.fn.matchend(line, [[\<\k\k\+\>]], col)
    end
    lnum = lnum + 1
  end
  return words
end

---@param arg_lead string
---@param _cmd_line string
---@param _cursor_pos integer
---@return string[]
M.complete = function(arg_lead, _cmd_line, _cursor_pos)
  local start_with_search = vim.regex([=[^[/?]\k\+$]=])
  local does_not_start_with_search = vim.regex([=[^\k\+$]=])
  ---@type string[]
  local all_words
  if start_with_search:match_str(arg_lead) then
    local char = arg_lead:sub(1, 1)
    all_words = get_words()
    all_words = vim.tbl_map(
      ---@param word string
      function(word)
        return char .. word
      end,
      all_words
    )
  elseif does_not_start_with_search:match_str(arg_lead) then
    all_words = get_words()
  else
    return {}
  end

  ---@type table<string, boolean>
  local already_seen = {}

  local filtered_words = vim.tbl_filter(
    ---@param word string
    function(word)
      if already_seen[word] then
        return false
      end
      already_seen[word] = true
      return vim.startswith(word, arg_lead)
    end,
    all_words
  )
  return filtered_words
end

---@param opts abolish.command_opts|{preview_ns: integer}
---@param preview_ns integer
M.subvert_preview = function(opts, preview_ns)
  opts.preview_ns = preview_ns or api.nvim_create_namespace("abolish-preview")
  local t = M.subvert_dispatcher(opts)
  if not t then
    return DO_NOT_PREVIEW
  end
  if not t.pattern then
    return DO_NOT_PREVIEW
  end

  return PREVIEW_IN_CURRENT_BUFFER
end

M.coercions = {
  c = M.camelcase,
  m = M.mixedcase,
  p = M.mixedcase,
  s = M.snakecase,
  _ = M.snakecase,
  u = M.uppercase,
  U = M.uppercase,
  ["-"] = M.dashcase,
  k = M.dashcase,
  ["."] = M.dotcase,
  [" "] = M.spacecase,
}

local l = vim.lpeg
local P, S, V, C, Cg, Cmt, Cb, Ct = l.P, l.S, l.V, l.C, l.Cg, l.Cmt, l.Cb, l.Ct
local locale = l.locale({}) ---@type table<string, vim.lpeg.Pattern>

-- Own flags
-- I: Disable case variations (box, Box, BOX)
-- v: Match inside variable names (match my_box, myBox, but not mybox)
-- w: Match whole words (like surrounding with \< and \>)
M.subvert_grammar = P({
  "command",
  prefix = Cg(locale.alpha ^ 1, "command"),
  separator = -S([[\"| ]]) * -locale.alnum * 1,
  start_separator = Cg(V("separator"), "separator"),
  end_separator = Cmt(C(V("separator")) * Cb("separator"), function(_s, _i, a, b)
    return a == b
  end),
  char = locale.alnum + S("_-."),
  fragment = C(V("char") ^ 0) * P(",") + C(V("char") ^ 0) * P("}"),
  section = Ct(
    Cg(V("char") ^ 0, "before") * Cg(Ct((P("{") * V("fragment") ^ 1) ^ -1), "fragments") * Cg(V("char") ^ 0, "after")
  ),
  pattern = Cg(V("section"), "pattern"),
  string = Cg(V("section"), "string"),
  vim_flags = S("&ceginp#lr"),
  own_flags = S("Ivw"),
  flags = Cg((V("vim_flags") + V("own_flags")) ^ 0, "flags"),
  command = Ct(
    V("prefix") ^ -1
      * V("start_separator")
      * V("pattern")
      * (V("end_separator") * V("string") * (V("end_separator") * V("flags")) ^ -1) ^ -1
  ),
})

M.find_grammar = P({
  "command",
  prefix = Cg(locale.alpha ^ 1, "command"),
  separator = -S([[\"| ]]) * -locale.alnum * 1,
  start_separator = Cg(V("separator"), "separator"),
  end_separator = Cmt(C(V("separator")) * Cb("separator"), function(_s, _i, a, b)
    return a == b
  end),
  char = locale.alnum + S("_-."),
  fragment = C(V("char") ^ 0) * P(",") + C(V("char") ^ 0) * P("}"),
  section = Ct(
    Cg(V("char") ^ 0, "before") * Cg(Ct((P("{") * V("fragment") ^ 1) ^ -1), "fragments") * Cg(V("char") ^ 0, "after")
  ),
  pattern = Cg(V("section"), "pattern"),
  vim_flags = S("&ceginp#lr"),
  own_flags = S("Ivw"),
  flags = Cg((V("vim_flags") + V("own_flags")) ^ 0, "flags"),
  command = Ct(V("prefix") ^ -1 * V("start_separator") * V("pattern") * (V("end_separator") * V("flags")) ^ -1),
})

---@class abolish.section
---@field before string
---@field after string
---@field fragments string[]

---@class abolish.parsed_input
---@field command string
---@field separator string
---@field pattern abolish.section
---@field string? abolish.section
---@field flags string

---@param opts abolish.command_opts | {preview_ns: integer|nil}
---@return abolish.parsed_input?
M.subvert_dispatcher = function(opts)
  local t = M.subvert_grammar:match(opts.args) --[[@as abolish.parsed_input?]]
  if not t then
    if not opts.preview_ns then
      vim.notify(("Invalid input: %s"):format(opts.args), vim.log.levels.ERROR)
    end
    return
  end

  parse_substitute(opts.preview_ns, opts.line1, opts.line2, opts.count, t)
  return t
end

---@param opts abolish.command_opts | {preview_ns: integer|nil}
---@return abolish.parsed_input?
M.find_dispatcher = function(opts)
  local t = M.find_grammar:match(opts.args) --[[@as abolish.parsed_input?]]
  if not t then
    if not opts.preview_ns then
      vim.notify(("Invalid input: %s"):format(opts.args), vim.log.levels.ERROR)
    end
    return
  end

  find_command(t)
end

vim.api.nvim_create_user_command("S", M.subvert_dispatcher, {
  bang = true,
  bar = true,
  nargs = 1,
  complete = M.complete,
  force = true,
  range = 0,
  preview = M.subvert_preview,
})

vim.api.nvim_create_user_command("F", M.find_dispatcher, {
  bang = true,
  bar = true,
  nargs = 1,
  complete = M.complete,
  force = true,
  range = 0,
})

vim.keymap.set("n", "cr", function()
  local motion = M.coerce()
  if not motion then
    return
  end
  return motion .. "iw"
end, { expr = true, desc = "Coerce iw" })

vim.keymap.set({ "x", "n" }, "<leader>cr", M.coerce, { expr = true, desc = "Coerce operator" })

-- Let's call it PascalCase, not MixedCase
vim.keymap.set("n", "crp", "crm", { remap = true })
-- Also kebabcase
vim.keymap.set("n", "cr-", "crk", { remap = true })

return M
