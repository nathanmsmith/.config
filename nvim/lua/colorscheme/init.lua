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

" Main Pallette
" Background: #011627


hi Normal guifg=#d6deeb ctermfg=253 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi LineNr guifg=#444444 ctermfg=238 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
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

hi Error guifg=#EF5350 guibg=NONE
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
hi LspDiagnosticsDefaultError guifg=#EF5350
hi LspDiagnosticsDefaultWarning guifg=#F78C6C
hi LspDiagnosticsDefaultInformation guifg=#82aaff
hi LspDiagnosticsDefaultHint guifg=#82aaff

hi LspDiagnosticsUnderlineError guifg=#EF5350 gui=undercurl
hi LspDiagnosticsUnderlineWarning guifg=#F78C6C gui=undercurl
hi LspDiagnosticsUnderlineInformation guifg=#82aaff gui=undercurl
hi LspDiagnosticsUnderlineHint guifg=#82aaff gui=undercurl

" Conflict markers: https://github.com/rhysd/conflict-marker.vim
highlight ConflictMarkerBegin guibg=#567f9a
highlight ConflictMarkerOurs guibg=#1f4055
highlight ConflictMarkerTheirs guibg=#0f1f3f
highlight ConflictMarkerEnd guibg=#2b2a5e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
]])

-- vim.cmd.colorscheme("night-owl")
