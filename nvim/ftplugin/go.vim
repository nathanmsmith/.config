" Because in Go we use tabs
setlocal noexpandtab
setlocal tabstop=2

let b:ale_linters = []

" Let vim-go handle running "go fmt" on save
let b:ale_fixers = []
" let g:go_fmt_command = "goimports"
