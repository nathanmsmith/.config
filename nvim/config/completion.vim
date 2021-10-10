" Vim-native completion

set omnifunc=v:lua.vim.lsp.omnifunc

" Ignore tags for completion by default
set complete-=t
set completeopt=menu

" Use enter to select completion
let g:SuperTabCrMapping = 1

" Use context completion. See *supertab-defaultcompletion*.
" Chaining unfortunately doesn't work with v:lua
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" Snippets
let g:python_host_prog = "python"
let g:python3_host_prog = "python3"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
