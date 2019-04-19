" Because in Go we use tabs
setlocal noexpandtab

let g:ale_linters = {'go': 'all'}

" Let vim-go handle running "go fmt" on save
let b:ale_fixers = []
let g:go_fmt_command = "goimports"

