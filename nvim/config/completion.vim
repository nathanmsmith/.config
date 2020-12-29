" Vim-native completion

if has('nvim-0.5')
  set omnifunc=v:lua.vim.lsp.omnifunc
end

" Ignore tags for completion by default
set complete-=t
set completeopt=menu

" Use enter to select completion
let g:SuperTabCrMapping = 1

" Use context completion. See *supertab-defaultcompletion*.
" Chaining unfortunately doesn't work with v:lua
let g:SuperTabDefaultCompletionType = 'context'


" Snippets
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
