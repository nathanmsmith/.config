let b:ale_linters = ['mypy', 'flake8']
let b:ale_fixers = ['black'] " having some issues with isort
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

let test#python#runner = 'pytest'
let b:ale_python_auto_pipenv = 1

" Highlights
let g:python_highlight_all = 1

setlocal omnifunc=v:lua.vim.lsp.omnifunc
