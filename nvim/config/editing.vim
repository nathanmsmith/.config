" editing.vim
" Settings involving editing files

" Map leader to space
let mapleader = ' '

" Disable swapfiles
set noswapfile

" Use system clipboard
set clipboard+=unnamedplus

" Whitespace characters settings
" refs:
" - http://vimcasts.org/episodes/tabs-and-spaces/
" - http://vimcasts.org/episodes/show-invisibles/
" View tabs as 2 spaces wide
set tabstop=2
" Ident by 2:
set shiftwidth=2
" Use spaces instead of tabs
set expandtab
" Tab to the current indent level
set smarttab
" Autoindent new lines
set autoindent

" Spell checking
" refs:
" - http://vimcasts.org/episodes/spell-checking/
" Spell file location
set spellfile=~/.config/nvim/spell/dictionary.utf-8.add
" 'Murican English
set spelllang=en_us
" No spelling by default
" Toggable by keyboard settings in unimpaired
" [os to enable
" ]os to disable
" =os to toggle
set nospell

" Searching
" Case insensitive by default, case sensitive with an uppercase char
set ignorecase
set smartcase
" Clear search buffer on return
nnoremap <silent> <CR> :nohlsearch<CR>
" Search selection is visual mode

"" Replacing
set inccommand=nosplit
"" Vim's substitute command is not interactive.

" make Y consistent with C and D.
nnoremap Y y$

" Let's call it PascalCase, not MixedCase
nmap crp crm
" Also kebabcase
nmap cr- crk

" Change definition of word
let g:wordmotion_spaces = ''

augroup editing
  " Highlight yanks
  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=1000}
augroup END

augroup external
  " Open images in an image viewer (probably Preview)
  autocmd BufEnter *.png,*.jpg,*.gif exec "silent !open ".expand("%") | :bw
augroup END
