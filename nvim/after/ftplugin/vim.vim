" By default, commentstring doesn't have a space
set commentstring=\"\ %s
" Autocomplete for vim lsp
setlocal omnifunc=v:lua.vim.lsp.omnifunc
" Linters
let b:ale_linters = ['vint']
