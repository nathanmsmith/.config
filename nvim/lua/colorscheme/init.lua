local palette = {
  none = "NONE",
  fg = "#d6deeb",
  bg = "#011627",
  folded_bg = "#092135",
  cursor_fg = "#805a3e",
  cursor_bg = "#80a4c2",
  line_number_fg = "#444444",
  line_number_active_fg = "#c5e4fc",
  sign_add = "#9ccc65",
  sign_change = "#e2b93d",
  sign_delete = "#ef5350",
  indent_guide = "#1f395d",
  indent_guide_active = "#7e97ac",
  visual = "#1d3b53",
  match_paren = "#1e364a",
  search_blue = "#063e5d",
  incremental_search_blue = "#2E485C",
  error = "#ef5350",
  word_highlight = "#33384d",
  word_highlight_write = "#2f3350",
  changed = "#a2bffc",
  quickfix_line = "#0e293f",
  ui_border = "#5f7e97",
  ui_border2 = "#20395d",
  nvim_tree_file = "#89a4bb",
  nvim_tree_indent_marker = "#585858",
  tab_active_bg = "#0b2942",
  tab_inactive_bg = "#01111d",
  parameter = "#d7dbe0",
  string_delimiter = "#d9f5dd",
  dark = "#010d18",
  dark2 = "#021320",
  dark3 = "#99b76d23",
  white = "#ffffff",
  white2 = "#eeefff",
  dark_white = "#cccccc",
  gray = "#262a39",
  gray2 = "#d2dee7",
  gray3 = "#36414a",
  gray4 = "#d6deeb80",
  gray5 = "#969696",
  gray6 = "#7e97ac",
  light_blue = "#78ccf0",
  blue = "#82aaff",
  blue2 = "#0b253a",
  blue3 = "#122d42",
  blue4 = "#1b90dd4d",
  blue5 = "#234d70",
  blue6 = "#234d708c",
  blue7 = "#395a75",
  blue8 = "#5ca7e4",
  blue9 = "#5f7e9779",
  blue10 = "#697098",
  blue11 = "#8eace3",
  blue12 = "#b2ccd6",
  blue13 = "#072232",
  blue14 = "#273845",
  blue15 = "#169fff",
  green = "#addb67",
  green2 = "#6CC85E",
  light_cyan = "#caece6",
  cyan = "#6ae9f0",
  cyan2 = "#7fdbca",
  cyan3 = "#7fdbcaff",
  cyan4 = "#80cbc4",
  cyan5 = "#baebe2",
  dark_cyan = "#637777",
  light_red = "#ff869a",
  red = "#ff5874",
  red2 = "#ff6363",
  red3 = "#ef535090",
  dark_red = "#ab0300f2",
  light_orange = "#ecc48d",
  orange = "#f78c6c",
  orange2 = "#ffcb8b",
  light_yellow = "#faf39f",
  yellow = "#ffd602",
  yellow2 = "#b39554",
  yellow3 = "#fad430",
  yellow4 = "#ffeb95",
  yellow5 = "#ffeb95cc",
  light_purple = "#a599e9",
  purple = "#7e57c2",
  purple2 = "#5166F0",
  purple3 = "#da70d6",
  purple4 = "#7986e7",
  dark_purple = "#2E2D5E",
  magenta = "#c792ea",
  magenta2 = "#c789d6",
  magenta3 = "#d1aaff",
  magenta4 = "#ff2c83",
  magenta5 = "#e2a2f433",
  magenta6 = "#f6bbe533",
}

--- @param name string
--- @param val? table<string, any>
local function hl(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

vim.cmd([[
" ===============================================================
" night-owl
"
" URL: https://github.com/haishanh/night-owl.vim
" Author: Haishan
" License: MIT
" Last Change: 2019/12/18 10:28
" ===============================================================

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="night-owl"

]])

hl("Normal", { fg = palette.fg, bg = palette.bg })
hl("LineNr", { fg = palette.line_number_fg, bg = palette.none })

hl("Error", { fg = palette.error, bg = palette.none })

hl("Cursor", { fg = palette.cursor_fg, bg = palette.cursor_bg })

-- Generic language highlighting
-- https://github.com/sdras/night-owl-vscode-theme/blob/master/themes/Night%20Owl-color-theme.json#L249-L255
hl("Comment", { fg = palette.dark_cyan, italic = true })
hl("Constant", { fg = palette.red })
hl("String", { fg = palette.light_orange })
hl("Number", { fg = palette.orange })
hl("Boolean", { fg = palette.red })
hl("Identifier", { fg = palette.cyan2 })
hl("Function", { fg = palette.blue, italic = true })
hl("Identifier", { fg = palette.cyan2 })
hl("FuncBuiltIn", { fg = palette.green })
hl("Statement", { fg = palette.magenta })
hl("Keyword", { fg = palette.magenta })
hl("Exception", { fg = palette.magenta, italic = true })
hl("PreProc", { fg = palette.magenta, italic = true })
hl("Type", { fg = palette.green })
hl("StorageClass", { fg = palette.magenta })
hl("Structure", { fg = palette.magenta })
hl("Todo", { fg = palette.red })
hl("SpellBad", { fg = palette.red, undercurl = true })
hl("ClassName", { fg = palette.light_orange })
hl("Modifier", { fg = palette.magenta, italic = true })
hl("Operator", { fg = palette.magenta })
hl("MatchParen", { fg = palette.red, bold = true })

-- https://github.com/neovim/neovim/issues/9800
hl("CursorLine", { bg = "#112630" })
hl("CursorLineNr", { fg = "#aaaaaa", bg = "#112630" })
hl("ColorColumn", { bg = "#222222" })
hl("Directory", { fg = palette.blue })
hl("Special", { fg = palette.orange })
hl("Conceal", { fg = palette.ui_border2 })
hl("Delimiter", { link = "NONE" })

hl("DiffAdd", { fg = "#99b76d", bg = "#121e3d" })
hl("DiffChange", { fg = palette.fg })
hl("DiffDelete", { fg = palette.sign_delete, bg = "#221f3d" })
hl("DiffText", { fg = palette.green })

hl("VertSplit", { fg = palette.bg })
hl("Folded", { fg = "#777777", bg = "#011627" })
hl("FoldColumn", { fg = "#333333", bg = "#011627" })
hl("SignColumn", { bg = "#011627" })
hl("IncSearch", { fg = "#eeeeee", bg = palette.light_orange })
hl("NonText", { fg = "#444444" })
hl("PMenu", { bg = "#2d2c5d" })
hl("PMenuSel", { bg = palette.magenta })
hl("Search", { fg = "#011627", bg = palette.light_orange })
hl("SpecialKey", { fg = palette.light_orange })
hl("Title", { fg = palette.blue, bold = true })
hl("Visual", { fg = palette.fg, bg = "#2d2c5d" })
hl("EndOfBuffer", { fg = "#444444", bg = "#011627" })

-- Statusline
hl("StatusLine", { bg = palette.bg, fg = palette.blue })
hl("StatusLineNC", { bg = palette.bg, fg = palette.ui_border })
hl("User1", { fg = palette.blue })
hl("User2", { fg = palette.blue, italic = true })

-- Tabline
hl("TabLine", { bg = palette.bg, fg = "#aaaaaa" })
hl("TabLineFill", { bg = palette.bg, fg = palette.ui_border })
hl("TabLineSel", { bg = palette.bg, fg = palette.green })

-- Diagnostics
hl("DiagnosticError", { link = "Error" })
hl("DiagnosticWarn", { fg = palette.orange })
hl("DiagnosticInfo", { fg = palette.blue })
hl("DiagnosticHint", { fg = palette.blue })
hl("DiagnosticUnderlineError", { sp = palette.error, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = palette.orange, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = palette.blue, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = palette.blue, undercurl = true })

-- flash.nvim (https://github.com/folke/flash.nvim)
-- hl("FlashBackdrop", {link = "Comment"})
-- hl("FlashMatch", { fg = palette.red, bg = palette.none })
-- hl("FlashCurrent", { fg = palette.red, bg = palette.none })
-- hl("FlashLabel", { fg = palette.red, bg = palette.none })
-- hl("FlashPrompt", { fg = palette.red, bg = palette.none })
-- hl("FlashPromptIcon", { fg = palette.red, bg = palette.none })
-- hl("FlashCursor", { fg = palette.green, bg = palette.none })

-- eyeliner.nvim
hl("EyelinerPrimary", { fg = palette.red, bold = true, underline = true })
hl("EyelinerSecondary", { fg = palette.orange, underline = true })

-- conflict-marker.vim (https://github.com/rhysd/conflict-marker.vim)
hl("ConflictMarkerBegin", { bg = "#567f9a" })
hl("ConflictMarkerOurs", { bg = "#1f4055" })
hl("ConflictMarkerTheirs", { bg = "#0f1f3f" })
hl("ConflictMarkerEnd", { bg = "#2b2a5e" })
hl("ConflictMarkerCommonAncestorsHunk", { bg = "#754a81" })

-- gitsigns.nvim
hl("GitSignsAdd", { fg = palette.sign_add })
hl("GitSignsChange", { fg = palette.sign_change })
hl("GitSignsDelete", { fg = palette.sign_delete })
