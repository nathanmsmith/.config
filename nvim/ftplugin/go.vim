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

" Let ALE handle running "go fmt" on save
let b:ale_linters = ["gobuild", "golangci-lint"]
let b:ale_fixers = ["goimports"]
let g:go_fmt_autosave = 0
let g:go_fmt_fail_silently = 1
