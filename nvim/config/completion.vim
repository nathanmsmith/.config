" Vim-native completion
" set complete=".,w,b,u"
" set completeopt=longest,menuone
" TODO: move this to only attach on lsp languages
set omnifunc=v:lua.vim.lsp.omnifunc

" Snippets
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
