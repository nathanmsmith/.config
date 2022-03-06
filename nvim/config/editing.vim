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
" nnoremap <silent> <CR> :nohlsearch<CR>
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

" Global substitution by default
set gdefault

" Git conflict markers
" Unimpaired does this [n and ]n (and d[n, d]n)
let g:conflict_marker_enable_mappings = 0
" disable the default highlight group
let g:conflict_marker_highlight_group = ''
" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81

augroup editing
  " Highlight yanks
  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=1000}
augroup END

augroup external
  " Open images in an image viewer (probably Preview)
  autocmd BufEnter *.png,*.jpg,*.gif exec "silent !open ".expand("%") | :bw
augroup END

" Wordmotion spaces
let g:wordmotion_spaces = ['\w\@<=-\w\@=', '\w\@<=_\w\@=', '\.', ':']

" cs%, etc
let g:matchup_surround_enabled = 1
let g:matchup_matchparen_offscreen = {}

" Use persistent undo history.
 set undodir=~/.local/share/nvim/
 set undofile
