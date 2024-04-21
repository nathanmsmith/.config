local palette = {
  none = "NONE",
  fg = "#d6deeb",
  bg = "#021727",
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
  green = "#c5e478",
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

local function hl(name, def)
  vim.api.nvim_set_hl(0, name, def)
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

" hi Normal guifg=#d6deeb ctermfg=253 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
" hi LineNr guifg=#444444 ctermfg=238 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE

" TODO: https://github.com/neovim/neovim/issues/9800
hi CursorLine guifg=NONE guibg=#112630 gui=NONE
hi CursorLineNr guifg=#aaaaaa ctermfg=248 guibg=#112630 ctermbg=235 gui=NONE cterm=NONE
hi ColorColumn guibg=#222222 ctermbg=235 gui=NONE cterm=NONE
hi Directory guifg=#82aaff ctermfg=111 gui=NONE cterm=NONE
hi Special guifg=#F78C6C gui=NONE
hi Conceal guifg=#20395d guibg=NONE
hi link Delimiter NONE


hi DiffAdd guifg=#99b76d guibg=#121e3d gui=NONE
hi DiffChange guifg=#d6deeb guibg=NONE gui=NONE cterm=NONE
hi DiffDelete guifg=#EF5350 guibg=#221f3d
hi DiffText guifg=#addb67 guibg=NONE gui=NONE cterm=NONE
" hi diffAdded guifg=#addb67 ctermfg=149 gui=NONE cterm=NONE
" hi diffRemoved guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE

hi VertSplit guifg=#011627 guibg=NONE gui=NONE
hi Folded guifg=#777777 ctermfg=243 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi FoldColumn guifg=#333333 ctermfg=236 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi SignColumn guifg=NONE ctermfg=NONE guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi IncSearch guifg=#eeeeee ctermfg=255 guibg=#ecc48d ctermbg=222 gui=NONE cterm=NONE
hi NonText guifg=#444444 ctermfg=238 gui=NONE cterm=NONE
hi PMenu guibg=#2d2c5d ctermbg=236 gui=NONE cterm=NONE
hi PMenuSel guibg=#c792ea ctermbg=176 gui=NONE cterm=NONE
hi Search guifg=#011627 ctermfg=233 guibg=#ecc48d ctermbg=222 gui=NONE cterm=NONE
hi SpecialKey guifg=#ecc48d ctermfg=222 gui=NONE cterm=NONE
hi Title guifg=#82aaff ctermfg=111 gui=bold cterm=bold
hi Visual guifg=#d6deeb ctermfg=253 guibg=#2d2c5d ctermbg=236 gui=NONE cterm=NONE
hi EndOfBuffer guifg=#444444 ctermfg=238 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE

hi MatchParen guifg=#ef5350 guibg=NONE gui=bold

" Statusline
hi StatusLine guifg=#011627 guibg=#5ca7e4
hi StatusLineNC guifg=#011627 guibg=#5f7e97
hi User1 guifg=#82aaff
hi User2 guifg=#82aaff gui=italic

" Text width colorcolumn
hi ColorColumn guibg=#1F2330

" Generic language highlighting
" Comment
" https://github.com/sdras/night-owl-vscode-theme/blob/master/themes/Night%20Owl-color-theme.json#L249-L255
hi Comment guifg=#637777 ctermfg=243 gui=italic cterm=italic


hi Constant guifg=#ff5874
hi String guifg=#ecc48d
hi Number guifg=#F78C6C
hi Boolean guifg=#ff5874

hi Identifier guifg=#7fdbca
hi Function guifg=#82aaff guibg=NONE gui=italic
hi FuncBuiltIn guifg=#addb67 gui=NONE

hi Statement guifg=#c792ea
hi Keyword guifg=#c792ea
hi Exception guifg=#c792ea gui=italic

hi PreProc guifg=#c792ea gui=italic

hi Type guifg=#addb67 ctermfg=149 gui=NONE cterm=NONE
hi StorageClass guifg=#c792ea
hi Structure guifg=#c792ea

hi Todo guifg=#EF5350 guibg=NONE

hi SpellBad guifg=#EF5350 gui=undercurl


" Custom Highlights
hi ClassName guifg=#ecc48d
hi Modifier guifg=#c792ea gui=italic


" TODO: Operator mode?
hi Operator guifg=#c792ea ctermfg=176 gui=NONE cterm=NONE

" JavaScript
hi jsStorageClass guifg=#82aaff ctermfg=111 gui=NONE cterm=NONE
hi jsOperator guifg=#c792ea ctermfg=176 gui=NONE cterm=NONE
hi jsArrowFunction guifg=#c792ea
hi jsString guifg=#ecc48d ctermfg=222 gui=NONE cterm=NONE
hi jsComment guifg=#637777 ctermfg=243 gui=italic cterm=italic
hi jsFuncCall guifg=#82aaff gui=italic
hi jsNumber guifg=#f78c6c ctermfg=209 gui=NONE cterm=NONE
hi jsSpecial guifg=#f78c6c ctermfg=209 gui=NONE cterm=NONE
hi jsObjectProp guifg=#7fdbca ctermfg=116 gui=NONE cterm=NONE
hi jsOperatorKeyword guifg=#7fdbca ctermfg=116 gui=NONE cterm=NONE
hi jsBooleanFalse guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
hi jsBooleanTrue guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
hi jsRegexpString guifg=#5ca7e4 ctermfg=74 gui=NONE cterm=NONE
hi jsConditional guifg=#c792ea ctermfg=176 gui=NONE cterm=NONE
hi link jsNull Constant
hi link jsUndefined Constant
hi jsReturn guifg=#c792ea ctermfg=176 gui=NONE cterm=NONE
hi jsFuncName guifg=#82aaff ctermfg=111 gui=NONE cterm=NONE
hi link jsParensError jsFuncParens
hi link jsClassDefinition ClassName
hi link jsThis Identifier
hi link jsSuper Identifier
hi jsImport guifg=#c792ea ctermfg=176 gui=italic cterm=italic
hi jsFrom guifg=#c792ea ctermfg=176 gui=italic cterm=italic
hi jsModuleAs guifg=#c792ea ctermfg=176 gui=italic cterm=italic
hi jsExport guifg=#7fdbca ctermfg=116 gui=NONE cterm=NONE
hi jsExportDefault guifg=#7fdbca ctermfg=116 gui=NONE cterm=NONE
hi link jsExtendsKeyword Modifier
hi javaScriptReserved guifg=#82aaff ctermfg=111 gui=NONE cterm=NONE
hi javaScriptConditional guifg=#c792ea ctermfg=176 gui=NONE cterm=NONE
hi javaScriptStringS guifg=#ecc48d ctermfg=222 gui=NONE cterm=NONE
hi javaScriptBoolean guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
hi javaScriptLineComment guifg=#637777 ctermfg=243 gui=italic cterm=italic
hi javaScriptSpecial guifg=#f78c6c ctermfg=209 gui=NONE cterm=NONE
hi javaScriptFunction guifg=#82aaff ctermfg=111 gui=NONE cterm=NONE
hi javaScriptStatement guifg=#c792ea ctermfg=176 gui=NONE cterm=NONE
hi javaScriptException guifg=#addb67 ctermfg=149 gui=NONE cterm=NONE

" TypeScript
hi link typescriptClassName ClassName
hi link typescriptClassHeritage ClassName
hi link typescriptClassExtends Modifier
hi link typescriptImport Modifier
hi link typescriptExport Modifier
hi link typescriptDefault Modifier
hi link typescriptBOM Normal
hi link typescriptCastKeyword Modifier
hi typescriptArrowFunc guifg=#c792ea
hi link typescriptFuncArg Normal
hi link typescriptArrowFuncArg Normal
hi link typescriptIdentifier Identifier
hi typescriptTypeReference guifg=#ecc48d

" JSX
hi jsxComponentName guifg=#f78c6c
hi jsxBraces guifg=#d3423e

" CSS
hi cssProp guifg=#7fdbca
hi cssUnitDecorators guifg=#fbec9f
" hi scssSelectorName guifg=#addb67 ctermfg=149 gui=NONE cterm=NONE
hi cssTagName guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
hi cssClassName guifg=#addb67 ctermfg=149 gui=italic cterm=italic
hi cssFunctionName guifg=#addb67
" hi link cssClassNameDot cssClassName
" hi cssBraces guifg=#d6deeb ctermfg=253 gui=NONE cterm=NONE
" hi cssPositioningProp guifg=#7fdbca ctermfg=116 gui=NONE cterm=NONE
" hi cssIEUIProp guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
" hi scssFunctionName guifg=#addb67 ctermfg=149 gui=NONE cterm=NONE
" hi cssPositioningAttr guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
" hi cssTableAttr guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
" hi cssCommonAttr guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
" hi cssIncludeKeyword guifg=#7fdbca ctermfg=116 gui=NONE cterm=NONE
" hi cssKeyFrameSelector guifg=#addb67 ctermfg=149 gui=NONE cterm=NONE
" hi cssPseudoClassId guifg=#addb67 ctermfg=149 gui=italic cterm=italic
" hi cssBorderAttr guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
" hi cssValueLength guifg=#f78c6c ctermfg=209 gui=NONE cterm=NONE
" hi cssIdentifier guifg=#f4d554 ctermfg=221 gui=italic cterm=italic

" Markdown
hi markdownHeadingDelimiter guifg=#637777 ctermfg=243 gui=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#ecc48d ctermfg=222 gui=NONE cterm=NONE
hi markdownCode guifg=#aaaaaa ctermfg=248 gui=NONE cterm=NONE
hi mkdCodeStart guifg=#d6deeb ctermfg=253 gui=NONE cterm=NONE
hi mkdCodeEnd guifg=#d6deeb ctermfg=253 gui=NONE cterm=NONE
hi mkdLinkDef guifg=#7fdbca ctermfg=116 gui=NONE cterm=NONE
hi mkdCodeDelimiter guifg=#637777 ctermfg=243 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE

" HTML
" https://notabug.org/jorgesumle/vim-html-syntax
hi htmlTag guifg=#7fdbca
hi htmlTagName guifg=#7fdbca
hi htmlSpecialTagName guifg=#7fdbca
hi htmlArg guifg=#addb67

" Shell comment
" TODO: can we remove?
hi shComment guifg=#637777 ctermfg=243 guibg=#011627 ctermbg=233 gui=italic cterm=italic


" Git commit top line
" TODO: not sure if right color
hi gitcommitSummary guifg=#d6deeb ctermfg=253 gui=NONE cterm=NONE

" NERDTree Sidebar
hi NERDTreeDir guifg=#5f7e97 ctermfg=66 gui=NONE cterm=NONE
hi NERDTreeOpenable guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
hi NERDTreeClosable guifg=#ecc48d ctermfg=222 gui=NONE cterm=NONE
hi NERDTreeHelp guifg=#444444 ctermfg=238 gui=italic cterm=italic
hi NERDTreeUp guifg=#637777 ctermfg=243 gui=NONE cterm=NONE
hi NERDTreeDirSlash guifg=#637777 ctermfg=243 gui=NONE cterm=NONE

" Git Gutter
" See https://github.com/sdras/night-owl-vscode-theme/blob/c51978c52677fc8122206e10b60a053cdee0cf11/themes/Night%20Owl-color-theme.json#L110-L113
" https://github.com/airblade/vim-gitgutter
hi GitGutterAdd guifg=#9CCC65 ctermfg=149 gui=NONE cterm=NONE
hi GitGutterChange guifg=#e2b93d ctermfg=222 gui=NONE cterm=NONE
hi GitGutterDelete guifg=#EF5350 ctermfg=204 gui=NONE cterm=NONE
hi GitGutterChangeDelete guifg=#e2b93d ctermfg=222 gui=NONE cterm=NONE

" TODO: Diff Editor

" C/C++
hi cppModifier guifg=#c792ea gui=italic

" Python
" https://github.com/vim-python/python-syntax/blob/master/syntax/python.vim
" Seems like there's not a lot that we can highlight, e.g., function calls and
" class names
hi pythonBuiltinFunc guifg=#addb67

" Ruby
" https://github.com/vim-ruby/vim-ruby
hi link rubyModuleName Normal
hi link rubyClassName ClassName
hi rubyBlockParameterList guifg=#addb67

" nvim LSP diagnostic
" hi DiagnosticsDefaultError guifg=#EF5350
" hi DiagnosticsDefaultWarn guifg=#F78C6C
" hi DiagnosticsDefaultInfo guifg=#82aaff
" hi DiagnosticsDefaultHint guifg=#82aaff

" hi DiagnosticsUnderlineError guifg=#EF5350 gui=undercurl
" hi DiagnosticsUnderlineWarn guifg=#F78C6C gui=undercurl
" hi DiagnosticsUnderlineInfo guifg=#82aaff gui=undercurl
" hi DiagnosticsUnderlineHint guifg=#82aaff gui=undercurl

" Conflict markers: https://github.com/rhysd/conflict-marker.vim
highlight ConflictMarkerBegin guibg=#567f9a
highlight ConflictMarkerOurs guibg=#1f4055
highlight ConflictMarkerTheirs guibg=#0f1f3f
highlight ConflictMarkerEnd guibg=#2b2a5e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
]])

hl("Normal", { fg = palette.fg, bg = palette.bg })
hl("LineNr", { fg = palette.line_number_fg, bg = palette.none })

hl("Error", { fg = palette.error, bg = palette.none })

hl("Cursor", { fg = palette.cursor_fg, bg = palette.cursor_bg })

-- Diagnostics
hl("DiagnosticError", { link = "Error" })
hl("DiagnosticWarn", { fg = palette.orange })
hl("DiagnosticInfo", { fg = palette.blue })
hl("DiagnosticHint", { fg = palette.blue })
hl("DiagnosticUnderlineError", { sp = palette.error, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = palette.orange, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = palette.blue, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = palette.blue, undercurl = true })

-- flash.nvim

-- hl("FlashBackdrop", {link = "Comment"})
hl("FlashMatch", { fg = palette.red, bg = palette.none })
hl("FlashCurrent", { fg = palette.red, bg = palette.none })
hl("FlashLabel", { fg = palette.red, bg = palette.none })
hl("FlashPrompt", { fg = palette.red, bg = palette.none })
hl("FlashPromptIcon", { fg = palette.red, bg = palette.none })
hl("FlashCursor", { fg = palette.green, bg = palette.none })
