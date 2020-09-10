call minpac#add('neovim/nvim-lsp', {'type': 'opt'})
call minpac#add('nvim-lua/lsp-status.nvim', {'type': 'opt'})
call minpac#add('nathunsmitty/diagnostic-nvim', {'type': 'opt'})
call minpac#add('nvim-lua/completion-nvim', {'type': 'opt'})

function InitializeLSP()
  packadd nvim-lsp
  packadd lsp-status.nvim
  packadd diagnostic-nvim
  packadd completion-nvim
  " LSP config, in lua
  lua require("lsp")
  setlocal omnifunc=v:lua.vim.lsp.omnifunc
endfunction

" Show errors after 1 second
set updatetime=1000
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1
" Complete parentheses for functions
let g:completion_enable_auto_paren = 1
" Work with endwise
let g:completion_confirm_key = "\<C-y>"
let g:completion_enable_snippet = 'UltiSnips'
