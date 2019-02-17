" Auto install Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" ==================================================
" Plug List
" ==================================================
call plug#begin('~/.config/nvim/plugged')

" --------------------------------------------------
" Themes, statuses, etc.
" --------------------------------------------------
Plug 'arcticicestudio/nord-vim'             " A nice theme
Plug 'vim-airline/vim-airline'              " Status bar

Plug 'kien/rainbow_parentheses.vim'

" --------------------------------------------------
" Git tools
" --------------------------------------------------

Plug 'airblade/vim-gitgutter'

" --------------------------------------------------
" General tools - linters, formatting, etc.
" --------------------------------------------------
Plug 'tpope/vim-commentary'                 " Commenting support (gc)
Plug 'tpope/vim-surround'                   " Surrounding text shortcuts
Plug 'tpope/vim-repeat'                     " Use `.` for plugins
Plug 'rizzatti/dash.vim'                    " Dash Integration
Plug '/usr/local/opt/fzf'                   " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'                             " Linting and LSP support

" --------------------------------------------------
" 1.2 JavaScript/TypeScript
" --------------------------------------------------

" Moder JS support (indent, syntax, etc)
Plug 'pangloss/vim-javascript'
" JSX syntax
Plug 'mxw/vim-jsx', { 'for': ['jsx', 'javascript.jsx'] }

" JSDoc generation
Plug 'heavenshell/vim-jsdoc'

" CSS-in-JS Support
Plug 'styled-components/vim-styled-components', {'branch': 'main'}
" TypeScript Syntax
Plug 'leafgarland/typescript-vim'
" TSX Support
Plug 'ianks/vim-tsx'
" Add flow typing support
Plug 'flowtype/vim-flow'

" --------------------------------------------------
" 1.2 GraphQL
" --------------------------------------------------
Plug 'jparise/vim-graphql'

" --------------------------------------------------
" 1.3 HTML/CSS
" --------------------------------------------------

" HTML5 syntax
Plug 'othree/html5.vim'
" Emmett HTML completion
Plug 'mattn/emmet-vim', { 'for': ['javascript.jsx', 'typescript.tsx', 'html', 'css'] }



Plug 'dag/vim-fish'

call plug#end()

" --------------------------------------------------
" 1.4 C
" --------------------------------------------------
" Plug 'vim-scripts/aftersyntaxc.vim', { 'dir': 'after/' }

" ==================================================
" 2.0 Basic settings
"   (Neovim defaults: https://neovim.io/doc/user/vim_diff.html#nvim-option-defaults)
" ==================================================
set nocompatible                            " Use Vim, not vi. This should be set by default, but let's make it explicit.
set number                                  " Line numbers on
set showmode                                " Always show mode
set nowrap                                  " Do not wrap long line
set showcmd                                 " Show commands as you type them
" set cmdheight=1                             " Command line height
" set pumheight=10                            " Completion window max size
set noswapfile                              " New buffers will be loaded without creating a swapfile
" set hidden                                  " Enables to switch between unsaved buffers and keep undo history
set clipboard+=unnamed                      " Allow to use system clipboard
" set nostartofline                           " Prevent cursor from moving to beginning of line when switching buffers

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" See https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
" and https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
:au VimLeave * set guicursor=a:ver25-blinkon1

if &shell =~# 'fish$'
    set shell=sh
endif


" --------------------------------------------------
" Autocompletion
" aka intellisense, omnicomplete
" refs:
" - http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" --------------------------------------------------
:set completeopt=longest,menuone
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" --------------------------------------------------
" Whitespace characters settings
" refs:
" - http://vimcasts.org/episodes/show-invisibles/
" --------------------------------------------------
" View tabs as 2 spaces wide
set tabstop=2
" Ident by 2:
set shiftwidth=2
" Use spaces instead of tabs
set expandtab
" Tab to the current indent level
set smarttab

set list                                    " Show listchars by default
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·,nbsp:·
set showbreak=↪




set termguicolors
syntax on
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_comment_brightness = 20
let g:nord_underline = 1
colorscheme nord

set guicursor=a:blinkon1

" Set this variable to 1 to fix files when you save them.
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 0
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1

" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)%

" https://stackoverflow.com/questions/19936145/vim-remove-whitespace-for-specific-files
fun! StripTrailingWhiteSpace()
  " don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun
autocmd bufwritepre * :call StripTrailingWhiteSpace()
