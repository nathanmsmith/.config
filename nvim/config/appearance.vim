" appearance.vim
" Settings styling vim

" Color Scheme
colorscheme night-owl

" Use true colors
set termguicolors

" don't syntax-highlight long lines
set synmaxcol=200

" Show whitespace
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:·,space:·

" Highlight the column after 'textwidth'
set colorcolumn=+1

" Set program title to 'nvim'
set title
setglobal titlestring=nvim

" Show line numbers
set number

" Highlight the current line, don't highlight the current column
set cursorline
set nocursorcolumn

" Always draw gutter for gitgutter, signify, etc.
set signcolumn=yes
let g:gitgutter_sign_priority = 9

" Don't redraw for macros
set lazyredraw

" Code Folding
" See https://github.com/w0rp/ale/issues/1829
" Don't set foldmethod=syntax
set foldlevelstart=99

" Colorize
if has('nvim')
  lua require 'colorizer'.setup(nil, { css = true; })
endif

augroup windows
  autocmd!
  " Evenly resize windows on terminal screen change.
  autocmd VimResized * :wincmd =
  " Split help windows vertically, on the right.
  autocmd FileType help wincmd L
augroup END

" Reset the cursor on exit
" See https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
" and https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
" set guicursor=a:blinkon100
augroup cursor
  autocmd!
  autocmd VimLeave,VimSuspend * set guicursor=a:ver25-blinkon1
augroup END

" Diff Mode
set diffopt+=vertical
