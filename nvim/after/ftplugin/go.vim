" Because in Go we use tabs
setlocal noexpandtab

" Vim-go all the colors
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
highlight link goBuiltins Keyword

let g:go_list_height = 0
let g:go_fmt_fail_silently = 1

" Let vim-go handle running "go fmt" on save
let b:ale_linters = ["gobuild", "golangci-lint"]
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = ''
let b:ale_fixers = []
let g:go_fmt_command = "goimports"

" nnoremap <buffer> gh :GoInfo<cr>
