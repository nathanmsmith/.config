packadd completion-nvim
packadd completion-buffers

 " Complete parentheses for functions
let g:completion_enable_auto_paren = 1
let g:completion_auto_change_source = 1
" let g:completion_chain_complete_list = [
"     \{'complete_items': ['lsp']},
"     \{'complete_items': ['buffers']}
" \]

let g:completion_trigger_keyword_length = 3

" Complete parentheses for functions
let g:completion_enable_auto_paren = 1
 " Work with endwise
let g:completion_confirm_key = "\<C-y>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
let g:completion_enable_snippet = 'UltiSnips'
