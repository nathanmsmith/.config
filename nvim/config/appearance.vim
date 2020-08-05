" appearance.vim
" Settings styling vim

" Color Scheme
call minpac#add('nathunsmitty/night-owl.vim')
colorscheme night-owl

" Resize windows on move
autocmd VimResized * :wincmd =

" Reset the cursor on exit
" See https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
" and https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
" set guicursor=a:blinkon100
:au VimLeave,VimSuspend * set guicursor=a:ver25-blinkon1

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

" Gitgutter
call minpac#add('airblade/vim-gitgutter')
if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" Don't redraw for macros
set lazyredraw

" Code Folding
" See https://github.com/w0rp/ale/issues/1829
" Don't set foldmethod=syntax
set foldlevelstart=99

"  " Rainbow Parentheses
"  " There are many different plugins out there for rainbow parentheses, this one is the most
"  " maintained.
"  " refs: https://github.com/luochen1990/rainbow
"  " call minpac#add('luochen1990/rainbow')
"  " let g:rainbow_active = 1
"  " let g:rainbow_conf = {
"  " \  'guifgs': ['#ffd700', '#da70d6', '#87cefa'],
"  " \  'operators': '',
"  " \  'separately': {
"  " \    'html': 0
"  " \  }
"  " \}
"
" Show colors for hex codes
call minpac#add('norcalli/nvim-colorizer.lua')
packadd nvim-colorizer.lua
lua require 'colorizer'.setup(nil, { css = true; })

" Highlight yanks
call minpac#add('machakann/vim-highlightedyank')

" Show marks in gutter
call minpac#add('kshenoy/vim-signature')

" Show clipboards and macros
call minpac#add('junegunn/vim-peekaboo')
let g:peekaboo_delay = 500
let g:peekaboo_compact = 1
