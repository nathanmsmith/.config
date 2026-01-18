-- Inspiration:
-- https://github.com/sdras/night-owl-vscode-theme/
-- https://css-tricks.com/creating-a-vs-code-theme/

local palette = {
  -- Core colors
  none = "NONE",
  fg = "#d6deeb",
  bg = "#011627",

  -- Cursor
  cursor_fg = "#805a3e",
  cursor_bg = "#80a4c2",
  cursorline_bg = "#112630",
  cursorline_number_fg = "#aaaaaa",

  -- UI elements
  line_number_fg = "#444444",
  ui_border = "#5f7e97",
  ui_border2 = "#20395d",
  colorcolumn_bg = "#222222",
  visual_bg = "#2d2c5d",

  -- Folding
  folded_fg = "#777777",
  foldcolumn_fg = "#333333",

  -- Search
  incsearch_fg = "#eeeeee",

  -- Syntax colors
  blue = "#82aaff",
  magenta = "#c792ea",
  red = "#ff5874",
  orange = "#f78c6c",
  light_orange = "#ecc48d",
  green = "#addb67",
  lime_green = "#c5e478",
  gold = "#ffcb8b",
  light_cyan = "#baebe2",
  dark_cyan = "#637777",
  cyan2 = "#7fdbca",

  -- Diagnostics
  error = "#ef5350",
  diagnostic_warn_line_bg = "#501010",

  -- Git signs
  sign_add = "#9ccc65",
  sign_change = "#e2b93d",
  sign_delete = "#ef5350",

  -- Diff colors
  diff_add_fg = "#99b76d",
  diff_add_bg = "#121e3d",
  diff_delete_bg = "#221f3d",

  -- Conflict markers
  conflict_begin = "#567f9a",
  conflict_ours = "#1f4055",
  conflict_theirs = "#0f1f3f",
  conflict_end = "#2b2a5e",
  conflict_ancestor = "#754a81",
}

--- @param name string
--- @param val? table<string, any>
local function hl(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

vim.cmd("highlight clear")

-- vim.opt.background = "dark"
vim.g.colors_name = "nightowl"
-- vim.opt.termguicolors = true

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
hl("CursorLine", { bg = palette.cursorline_bg })
hl("CursorLineNr", { fg = palette.cursorline_number_fg, bg = palette.cursorline_bg })
hl("ColorColumn", { bg = palette.colorcolumn_bg })
hl("Directory", { fg = palette.blue })
hl("Special", { fg = palette.orange })
hl("Conceal", { fg = palette.ui_border2 })
hl("Delimiter", { link = "NONE" })

hl("DiffAdd", { fg = palette.diff_add_fg, bg = palette.diff_add_bg })
hl("DiffChange", { fg = palette.fg })
hl("DiffDelete", { fg = palette.sign_delete, bg = palette.diff_delete_bg })
hl("DiffText", { fg = palette.green })

hl("WinSeparator", { fg = palette.line_number_fg })
hl("VertSplit", { fg = palette.line_number_fg })
hl("Folded", { fg = palette.folded_fg, bg = palette.bg })
hl("FoldColumn", { fg = palette.foldcolumn_fg, bg = palette.bg })
hl("SignColumn", { bg = palette.bg })
hl("IncSearch", { fg = palette.incsearch_fg, bg = palette.light_orange })
hl("NonText", { fg = palette.line_number_fg })
hl("PMenu", { bg = palette.visual_bg })
hl("PMenuSel", { bg = palette.magenta })
hl("Search", { fg = palette.bg, bg = palette.light_orange })
hl("SpecialKey", { fg = palette.light_orange })
hl("Title", { fg = palette.blue, bold = true })
hl("Visual", { fg = palette.fg, bg = palette.visual_bg })
hl("EndOfBuffer", { fg = palette.line_number_fg, bg = palette.bg })

-- Statusline
hl("StatusLine", { bg = palette.bg, fg = palette.blue })
hl("StatusLineNC", { bg = palette.bg, fg = palette.ui_border })
hl("User1", { fg = palette.blue })
hl("User2", { fg = palette.blue, italic = true })

-- Floats
hl("NormalFloat", { bg = palette.bg })
hl("FloatBorder", { link = "StatusLine" })

-- Tabline
hl("TabLine", { bg = palette.bg, fg = palette.cursorline_number_fg })
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
hl("DiagnosticErrorLine", { bg = palette.error })
hl("DiagnosticWarnLine", { bg = palette.diagnostic_warn_line_bg })
hl("DiagnosticInfoLine", { bg = palette.blue })
hl("DiagnosticHintLine", { bg = palette.blue })

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
hl("ConflictMarkerBegin", { bg = palette.conflict_begin })
hl("ConflictMarkerOurs", { bg = palette.conflict_ours })
hl("ConflictMarkerTheirs", { bg = palette.conflict_theirs })
hl("ConflictMarkerEnd", { bg = palette.conflict_end })
hl("ConflictMarkerCommonAncestorsHunk", { bg = palette.conflict_ancestor })

-- gitsigns.nvim
hl("GitSignsAdd", { fg = palette.sign_add })
hl("GitSignsChange", { fg = palette.sign_change })
hl("GitSignsDelete", { fg = palette.sign_delete })

hl("LspSignatureActiveParameter", { link = "Comment" })

-- Text
hl("@markup.raw", { link = "Comment" })
hl("@markup.link", { link = "Identifier" })
hl("@markup.heading", { link = "Title" })
hl("@markup.link.url", { link = "Underlined" })
hl("@markup.underline", { link = "Underlined" })
hl("@comment.todo", { link = "Todo" })

-- Miscs
hl("@comment", { link = "Comment" })
hl("@punctuation", { link = "Delimiter" })

-- Constants
hl("@constant", { link = "Constant" })
hl("@constant.builtin", { link = "Special" })
hl("@constant.macro", { link = "Define" })
hl("@keyword.directive", { link = "Define" })
hl("@string", { link = "String" })
hl("@string.escape", { link = "SpecialChar" })
hl("@string.special", { link = "SpecialChar" })
hl("@character", { link = "Character" })
hl("@character.special", { link = "SpecialChar" })
hl("@number", { link = "Number" })
hl("@boolean", { link = "Boolean" })
hl("@number.float", { link = "Float" })

-- Functions
hl("@function", { link = "Function" })
hl("@function.builtin", { link = "Special" })
hl("@function.macro", { link = "Macro" })
hl("@function.method", { link = "Function" })
hl("@variable.parameter", { link = "Identifier" })
hl("@variable.parameter.builtin", { link = "Special" })
hl("@variable.member", { link = "Identifier" })
hl("@property", { link = "Identifier" })
hl("@attribute", { link = "Macro" })
hl("@attribute.builtin", { link = "Special" })
hl("@constructor", { link = "Special" })

-- Keywords
hl("@keyword.conditional", { link = "Conditional" })
hl("@keyword.repeat", { link = "Repeat" })
hl("@keyword.type", { link = "Structure" })
hl("@label", { link = "Label" })
hl("@operator", { link = "Operator" })
hl("@keyword", { link = "Keyword" })
hl("@keyword.exception", { link = "Exception" })

hl("@variable", { link = "Identifier" })
hl("@type", { link = "Type" })
hl("@type.definition", { link = "Typedef" })
hl("@module", { link = "Identifier" })
hl("@keyword.import", { link = "Include" })
hl("@keyword.directive", { link = "PreProc" })
hl("@keyword.debug", { link = "Debug" })
hl("@tag", { link = "Tag" })
hl("@tag.builtin", { link = "Special" })

-- LSP semantic tokens
hl("@lsp.type.class", { link = "Structure" })
hl("@lsp.type.comment", { link = "Comment" })
hl("@lsp.type.decorator", { link = "Function" })
hl("@lsp.type.enum", { link = "Structure" })
hl("@lsp.type.enumMember", { link = "Constant" })
hl("@lsp.type.function", { link = "Function" })
hl("@lsp.type.interface", { link = "Structure" })
hl("@lsp.type.macro", { link = "Macro" })
hl("@lsp.type.method", { link = "Function" })
hl("@lsp.type.namespace", { link = "Structure" })
hl("@lsp.type.parameter", { link = "Identifier" })
hl("@lsp.type.property", { link = "Identifier" })
hl("@lsp.type.struct", { link = "Structure" })
hl("@lsp.type.type", { link = "Type" })
hl("@lsp.type.typeParameter", { link = "TypeDef" })
hl("@lsp.type.variable", { link = "Identifier" })

-- Trouble.nvim
hl("TroubleNormal", { link = "Normal" })
hl("TroubleNormalNC", { link = "Normal" })

-- nvim-bqf
-- https://github.com/kevinhwang91/nvim-bqf?tab=readme-ov-file#highlight-groups
hl("BqfPreviewRange", { fg = palette.light_orange })
-- hi default link BqfPreviewFloat Normal
-- hi default link BqfPreviewBorder FloatBorder
-- hi default link BqfPreviewTitle Title
-- hi default link BqfPreviewThumb PmenuThumb
-- hi default link BqfPreviewSbar PmenuSbar
-- hi default link BqfPreviewCursor Cursor
-- hi default link BqfPreviewCursorLine CursorLine
-- hi default link BqfPreviewRange IncSearch
-- hi default link BqfPreviewBufLabel BqfPreviewRange
-- hi default BqfSign ctermfg=14 guifg=Cyan

hl("LuasnipInsertNode", { fg = palette.blue })
hl("LuasnipChoiceNode", { fg = palette.orange })

-- Marks
hl("MarksSign", { fg = palette.red })

-- Treesitter Context
hl("TreesitterContext", { bg = palette.cursorline_bg })
hl("TreesitterContextLineNumber", { bg = palette.cursorline_bg })
