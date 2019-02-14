" Auto install Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" 1.0 Plug List
" ==================================================
call plug#begin('~/.config/nvim/plugged')

Plug 'haishanh/night-owl.vim'

" --------------------------------------------------
" 1.1 General tools - linters, formatting, etc.
" --------------------------------------------------
Plug 'tpope/vim-commentary'                 " Commenting support (gc)
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'

" --------------------------------------------------
" 1.2 JavaScript/TypeScript
" --------------------------------------------------

" Moder JS support (indent, syntax, etc)
Plug 'pangloss/vim-javascript'
" JSX syntax
Plug 'mxw/vim-jsx', { 'for': ['jsx', 'javascript.jsx'] }

" CSS-in-JS Support
Plug 'styled-components/vim-styled-components', {'branch': 'main'}
" TypeScript Syntax
Plug 'leafgarland/typescript-vim'
" Add flow typing support
Plug 'flowtype/vim-flow'

" --------------------------------------------------
" 1.3 HTML/CSS
" --------------------------------------------------

" HTML5 syntax
Plug 'othree/html5.vim'
" Emmett HTML completion
Plug 'mattn/emmet-vim', { 'for': ['javascript.jsx', 'html', 'css'] }



Plug 'dag/vim-fish'

call plug#end()


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


if &shell =~# 'fish$'
    set shell=sh
endif

" --------------------------------------------------
" 2.6 White characters settings
" refs:
" - http://vimcasts.org/episodes/show-invisibles/
" --------------------------------------------------



set list                                    " Show listchars by default
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·,nbsp:·
set showbreak=↪





set termguicolors
syntax on
colorscheme night-owl



