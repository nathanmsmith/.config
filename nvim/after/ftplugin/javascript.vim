let g:ale_javascript_prettier_options = "--single-quote --no-semi --trailing-comma es5"
let b:ale_fixers = ['eslint', 'prettier']
let b:ale_linters = ['eslint']


setlocal omnifunc=v:lua.vim.lsp.omnifunc
