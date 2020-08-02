" editing.vim
" Settings involving editing files

" Map leader to space
let mapleader = " "

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
call minpac#add('nelstrom/vim-visual-star-search')

"" Replacing
set inccommand=nosplit
"" Vim's substitute command is not interactive.

" make Y consistent with C and D.
nnoremap Y y$

" Tim Pope plugins that should be defaults
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-unimpaired')
" Helpful character metadata on `ga` 😍
call minpac#add('tpope/vim-characterize')
" Ctrl-a, ctrl-x for dates, times, etc.
call minpac#add('tpope/vim-speeddating')
" Add readline bindings for command line mode
call minpac#add('tpope/vim-rsi')
" Substitution and Coercion
call minpac#add('tpope/vim-abolish')
" Let's call it PascalCase, not MixedCase
nmap crp crm
" Also kebabcase
nmap cr- crk



" Change definition of word
call minpac#add('chaoren/vim-wordmotion')
let g:wordmotion_spaces = ''

" Additional Text Objects
call minpac#add('kana/vim-textobj-user')
call minpac#add('kana/vim-textobj-entire')
call minpac#add('wellle/targets.vim')

" Snippets
call minpac#add('SirVer/ultisnips')
call minpac#add('adriaanzon/vim-emmet-ultisnips')
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


"  " call minpac#add('tmsvg/pear-tree')
"  let g:pear_tree_smart_openers = 0
"  let g:pear_tree_smart_closers = 0
"  let g:pear_tree_smart_backspace = 0



"  call minpac#add('andrewradev/splitjoin.vim')
"  call minpac#add('AndrewRadev/tagalong.vim')




"  call minpac#add('tommcdo/vim-exchange')
"
"
"" When editing a file, always jump to the last known cursor position.
"" Don't do it when the position is invalid, when inside an event handler
"" (happens when dropping a file on gvim) and for a commit message (it's
"" likely a different one than last time).
"" Copied from defaults.vim)
"" See :h restore-cursor
"" TODO: There seems to be a bug where this happens for git commits too, so
"" disabling this for now.
"" autocmd VimEnter *
"  " \ if line("'\"") >= 1 && line("'\"") <= line("$") " && &ft != 'gitcommit'
"  " " \ |   exe "normal! g`\""
"  " \ | endif
