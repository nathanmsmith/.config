" Because in Go we use tabs
setlocal noexpandtab

" Disable LSP-y features
let g:go_gopls_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_echo_go_info = 0
let g:go_def_mapping_enabled = 0

" Vim-go all the colors
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1

highlight link goBuiltins Keyword

let g:go_list_height = 0
let g:go_fmt_fail_silently = 1

let b:ale_linters = ["golangci-lint", "goimports"]
let b:ale_go_golangci_lint_package = 1
let b:ale_go_golangci_lint_options = '--fast'
let b:ale_fixers = ["goimports"]

" nnoremap <buffer> gh :GoInfo<cr>
