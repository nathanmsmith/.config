" Nathan Smith's vim configuration


" Overarching Philosophy:
" 1. Prefer the defaults
" 2. Extend functionality where needed
" 3. Change functionality only when it doesn't make sense
"
"
"
"
"

" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif


" Reset the cursor on exit
" See https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
" and https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
:au VimLeave * set guicursor=a:ver25-blinkon1

" Map leader
let mapleader = " "

" Color Defaults
set background=dark
set termguicolors

" Searching
" Case insensitive by default, case sensitive with an uppercase char
set ignorecase
set smartcase
" Clear search buffer on return
nnoremap <silent> <CR> :nohlsearch<CR>

" Line Numbers
set number

" Status line
" TODO: set up vanilla status line
" set laststatus=2
" set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
" set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

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
" Show whitespace characters
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:·,space:·


" Buffers
" ref: http://vimcasts.org/episodes/working-with-buffers/
" Enables to switch between unsaved buffers and keep undo history
set hidden

" Windows
" ref: http://vimcasts.org/episodes/working-with-windows/
"


" More sensible window splits
set splitbelow
set splitright
" Split help windows vertically, on the right
autocmd FileType help wincmd L

" Use system clipboard
set clipboard+=unnamed

" Wildmenu
" set wildmenu
" set wildmode=list:full

" Mouse support
" Useful for things like resizing windows
if has('mouse')
  set mouse=a
end

" ARROW KEYS ARE UNACCEPTABLE
noremap <Left> :echo "no!"<cr>
noremap <Right> :echo "no!"<cr>
noremap <Up> :echo "no!"<cr>
noremap <Down> :echo "no!"<cr>

" grep with ripgrep
" https://github.com/BurntSushi/ripgrep
" if executable('rg')
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m
" endif

augroup vimStartup
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  " Copied from defaults.vim)
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

augroup END

" Code Folding
set foldmethod=syntax
set foldlevelstart=99

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

" Config comman
function! OpenInSplitIfBufferDirty(file)
  if line('$') == 1 && getline(1) == ''
    execute 'edit' a:file
  else
    execute 'vsplit' a:file
  endif
endfu
command! Config :call OpenInSplitIfBufferDirty($MYVIMRC)
" autocmd bufwritepost init.vim source $MYVIMRC

set diffopt+=vertical

" ==================================================
" Plugins
" Package manager: Minpac, https://github.com/k-takata/minpac
" ref: Modern Vim, tip 6
" ==================================================
" Easy to use commands
packadd minpac

command! PacInstall source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PacClean source $MYVIMRC | call minpac#clean()
command! PacStatus source $MYVIMRC | call minpac#status()

if exists('*minpac#init')
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Types of Plugins
  " Improvements: Overwrite Vim's default behaviour
  " Extensions: Extend Vim's functionality

  " Color Scheme
  call minpac#add('tyrannicaltoucan/vim-quantum')
  colorscheme quantum
  let g:quantum_italics=1

  " Sensible defaults
  " See https://github.com/tpope/vim-sensible for the full list
  " Use <C-L> to turn off highlighting after search
  call minpac#add('tpope/vim-sensible')

  " Easy commenting
  " This really should be a default, I don't know where I'd be without it
  call minpac#add('tpope/vim-commentary')

  " Quoting/Parenthesis made simple
  " Also should be a default
  call minpac#add('tpope/vim-surround')

  " Use `.` for plugins (Like commentary and surround)
  call minpac#add('tpope/vim-repeat')

  " Easier shortcuts for lots of miscellanea
  call minpac#add('tpope/vim-unimpaired')

  " Autodetect indentation
  call minpac#add('tpope/vim-sleuth')

  " Git commands in Vim
  call minpac#add('tpope/vim-fugitive')
  " Fugitive extensions for GitHub
  call minpac#add('tpope/vim-rhubarb')

  " Pluses and minuses in the sidebar!
  call minpac#add('airblade/vim-gitgutter')
  if exists('&signcolumn')
    set signcolumn=yes
  else
    let g:gitgutter_sign_column_always = 1
  endif

  " Editorconfig support
  call minpac#add('editorconfig/editorconfig-vim')
  " Make editorconfig play nice with Fugitive
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']

  " Helpful character metadata on `ga` 😍
  call minpac#add('tpope/vim-characterize')

  " Ctrl-a, ctrl-x for dates, times, etc.
  call minpac#add('tpope/vim-speeddating')

  call minpac#add('tpope/vim-eunuch')

  " Substitution and Coercion
  call minpac#add('tpope/vim-abolish')
  " Let's call it PascalCase, not MixedCase
  nmap crp crm
  " Also kebabcase
  nmap cr- crk

  " Handle swap files better
  call minpac#add('gioele/vim-autoswap')
  set title titlestring=

  " Dash Integration
  call minpac#add('rizzatti/dash.vim')

  " Better definitions of a word
  call minpac#add('chaoren/vim-wordmotion')

  " Fuzzy finding with FZF
  " refs:
  " - https://github.com/junegunn/fzf
  " - https://github.com/junegunn/fzf.vim
  " Source FZF from the homebrew install
  set rtp+=/usr/local/opt/fzf
  call minpac#add('junegunn/fzf.vim')
  " Using FZF
  nnoremap <silent> <leader>p :Files<CR>
  nnoremap <silent> <leader>b :Buffers<CR>

  " Airline Status Bar
  " ref: https://github.com/vim-airline/vim-airline
  call minpac#add('vim-airline/vim-airline')
  " " Enable buffer tab line
  " let g:airline#extensions#tabline#enabled = 1
  " " Square buffer tabs
  " let g:airline#extensions#tabline#left_sep = ' '
  " let g:airline#extensions#tabline#left_alt_sep = '|'
  " " Tab path formatting
  " let g:airline#extensions#tabline#formatter = 'jsformatter'
  let g:airline_theme='quantum'

  " Rainbow Parentheses
  " There are many different plugins out there for rainbow parentheses, this one is the most
  " maintained.
  " refs: https://github.com/luochen1990/rainbow
  call minpac#add('luochen1990/rainbow')
  let g:rainbow_active = 1
  let g:rainbow_conf = {
  \  'guifgs': ['#ffd700', '#da70d6', '#87cefa']
  \}

  " Snippets
  call minpac#add('adriaanzon/vim-emmet-ultisnips')
  call minpac#add('SirVer/ultisnips')
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsUsePythonVersion = 3
  let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips', 'UltiSnips']
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

  " ALE
  call minpac#add('w0rp/ale')
  let g:ale_fix_on_save = 1
  let g:airline#extensions#ale#enabled = 1
  let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'javascript.jsx': ['eslint', 'prettier'],
\   'typescript.tsx': ['eslint', 'prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'less': ['prettier'],
\   'json': ['prettier'],
\   'graphql': ['prettier'],
\}
  let g:ale_linter_aliases = {'typescriptreact': 'typescript'}
  let g:ale_javascript_eslint_suppress_missing_config = 1
  let g:ale_prolog_swipl_timeout = 10
  nmap <silent> [W <Plug>(ale_first)
  nmap <silent> [w <Plug>(ale_previous)
  nmap <silent> ]w <Plug>(ale_next)
  nmap <silent> ]W <Plug>(ale_last)
  nmap gh :ALEHover<cr>

  " LSP Support
  " Autocomplete
  " call minpac#add('Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'})
  " call minpac#add('fszymanski/deoplete-emoji')
  " let g:deoplete#enable_at_startup = 1
  " call minpac#add('autozimu/LanguageClient-neovim', {
  "   \ 'branch': 'next',
  "   \ 'do': 'bash install.sh',
  "   \ })

  " vim-test
  call minpac#add('janko-m/vim-test')
  let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|unit))\.(js|jsx|coffee|ts|tsx)$'
  let g:test#javascript#jest#executable = 'yarn test:unit'
  nnoremap <leader>t :TestNearest<cr>
  nnoremap <leader>T :TestFile<cr>
  nnoremap <leader>a :TestSuite<cr>

  "
  " Languages
  " Most of these are from vim-polyglot
  " (https://github.com/sheerun/vim-polyglot)
  "
  " Markdown
  call minpac#add('plasticboy/vim-markdown')
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_math = 1
  let g:vim_markdown_strikethrough = 1
  let g:vim_markdown_new_list_item_indent = 2
  set conceallevel=2
  " let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'ruby', 'sass', 'xml', 'html']
  " MDX support
  call minpac#add('jxnblk/vim-mdx-js')

  " C improvements
  call minpac#add('vim-scripts/aftersyntaxc.vim')
  " Fish
  call minpac#add('dag/vim-fish')
  " HTML
  call minpac#add('othree/html5.vim')
  " Handlebars
  call minpac#add('mustache/vim-mustache-handlebars')
  " CSS
  call minpac#add('JulesWang/css.vim')
  " call minpac#add('hail2u/vim-css3-syntax')
  " Sass
  call minpac#add('cakebaker/scss-syntax.vim')
  " Less
  call minpac#add('groenewege/vim-less')
  " Better JS support (indent, syntax, etc)
  call minpac#add('pangloss/vim-javascript')
  " JSX syntax
  call minpac#add('mxw/vim-jsx', { 'for': ['jsx', 'javascript.jsx'] })
  " JSDoc generation
  call minpac#add('heavenshell/vim-jsdoc')
  " CSS-in-JS Support
  call minpac#add('styled-components/vim-styled-components', {'branch': 'main'})
  " TypeScript Syntax
  " call minpac#add('leafgarland/typescript-vim')
  call minpac#add('HerringtonDarkholme/yats.vim') " YATS is better
  " TSX Support
  " call minpac#add('ianks/vim-tsx')
  " call minpac#add('peitalin/vim-jsx-typescript')
  " Add Flow support
  " call minpac#add('flowtype/vim-flow')
  " JSON
  call minpac#add('elzr/vim-json')
  " GraphQL
  call minpac#add('jparise/vim-graphql')
  " Ruby
  call minpac#add('vim-ruby/vim-ruby')
  " Ruby on Rails
  call minpac#add('tpope/vim-rails')
  " Go
  " Make sure to call :GoUpdateBinaries on install
  call minpac#add('fatih/vim-go')
  " Vim-go all the colors
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_types = 1
  " auto import deps
  let g:go_fmt_command = "goimports"

  " Rust
  call minpac#add('rust-lang/rust.vim')
  " TOML
  call minpac#add('cespare/vim-toml')

  " Evaluating
  call minpac#add('tpope/vim-projectionist')
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')
  " s for sidebar
  map <leader>s :NERDTreeToggle %<CR>
  call minpac#add('nelstrom/vim-visual-star-search')
  " Syntax highlighting for github's hub tool
  call minpac#add('jez/vim-github-hub')
  call minpac#add('dhruvasagar/vim-table-mode')
  call minpac#add('Alok/notational-fzf-vim')
  let g:nv_search_paths = ['~/wiki']

else
  colorscheme elflord

endif
