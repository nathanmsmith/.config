let b:ale_linters = ['mypy', 'flake8']
" let b:ale_fixers = ['isort', 'black']
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

let test#python#runner = 'pytest'
let g:ale_python_auto_pipenv = 1
