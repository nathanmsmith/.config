command! LSPHover <cmd>lua vim.lsp.buf.hover()<CR>

packadd nvim-lspconfig
packadd lsp-status.nvim
packadd diagnostic-nvim
packadd completion-nvim
" LSP config, in lua
lua require("lsp")
setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Show errors after 1 second
set updatetime=1000
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

let g:diagnostic_enable_ale = 1
" Complete parentheses for functions
let g:completion_enable_auto_paren = 1
" Work with endwise
let g:completion_confirm_key = "\<C-y>"
let g:completion_enable_snippet = 'UltiSnips'
