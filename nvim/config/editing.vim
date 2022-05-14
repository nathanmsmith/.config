" editing.vim
" Settings involving editing files

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

" Don't lose track of edits
set nohidden
