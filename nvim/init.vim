" Nathan Smith's vim configuration


" Overarching Philosophy:
" 1. Prefer the defaults
" 2. Extend functionality where needed
" 3. Change functionality only when it doesn't make sense
"
"


let s:uname = trim(system("uname -s"))

if s:uname == "Darwin"
  set rtp+=~/.fzf
else
  set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
endif

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
" set guicursor=a:blinkon100
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

" Replacing
set inccommand=nosplit
" Vim's substitute command is not interactive.

" Line Numbers
set number
set cursorline
set nocursorcolumn


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
set clipboard+=unnamedplus

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

" https://til.hashrocket.com/vim?name=vim&page=3
" :autocmd BufEnter *.png,*.jpg,*gif exec "! ~/.iterm2/imgcat ".expand("%") | :bw

" Code Folding
" See https://github.com/w0rp/ale/issues/1829
" set foldmethod=syntax
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

" Python support
if s:uname == "Darwin"
  let g:python_host_prog = "/usr/local/bin/python"
  let g:python3_host_prog = "/usr/local/opt/python@3.8/bin/python3"
endif


" Get syntax highlighting item
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" Rolling our own status line
set laststatus=2
set statusline=
set statusline+=%f
set statusline+=%m
set statusline+=\ %{FugitiveStatusline()}
set statusline+=%=
set statusline+=%{SyntaxItem()}
set statusline+=\ %y

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
  call minpac#add('nathunsmitty/night-owl.vim')
  colorscheme night-owl
  " colorscheme quantum

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
  " call minpac#add('editorconfig/editorconfig-vim')
  " Make editorconfig play nice with Fugitive
  " let g:EditorConfig_exclude_patterns = ['fugitive://.*']
  " No one tell me how big my tabs will be!
  " For real though, I was working on a Go project where the indent size was 4
  " and it drove me crazy until I figured out it was because of editorconfig
  " let g:EditorConfig_disable_rules = ['tab_width', 'indent_size']

  " Helpful character metadata on `ga` 😍
  call minpac#add('tpope/vim-characterize')

  " Ctrl-a, ctrl-x for dates, times, etc.
  call minpac#add('tpope/vim-speeddating')

  " Unix utilities
  call minpac#add('tpope/vim-eunuch')

  " Faster file switching with alternates
  " Also integrates with vim-test
  call minpac#add('tpope/vim-projectionist')
  let g:projectionist_heuristics = {
        \ '*.go': {
        \   '*.go': {
        \       'alternate': '{}_test.go',
        \       'type': 'source'
        \   },
        \   '*_test.go': {
        \       'alternate': '{}.go',
        \       'type': 'test'
        \   },
        \ },
        \ '*.js': {
        \   '*.js': {
        \       'alternate': '{}.test.js',
        \       'type': 'source'
        \   },
        \   '*.test.js': {
        \       'alternate': '{}.js',
        \       'type': 'test'
        \   },
        \ },
        \ '*.iced': {
        \   '*.iced': {
        \       'alternate': '{}.test.iced',
        \       'type': 'source'
        \   },
        \   '*.test.iced': {
        \       'alternate': '{}.iced',
        \       'type': 'test'
        \   },
        \ },
        \ '*.py': {
        \   '*.py': {
        \       'alternate': '{}_test.py',
        \       'type': 'source'
        \   },
        \   '*_test.py': {
        \       'alternate': '{}.py',
        \       'type': 'test'
        \   },
        \ }}

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

  " call minpac#add('907th/vim-auto-save')
  " let g:auto_save = 1

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
  nnoremap <silent> <leader>f :Rg<CR>

  " Lightline
  " call minpac#add('itchyny/lightline.vim')
  " let g:lightline = {
  "       \ 'colorscheme': 'nightowl',
  "       \ }

  " Rainbow Parentheses
  " There are many different plugins out there for rainbow parentheses, this one is the most
  " maintained.
  " refs: https://github.com/luochen1990/rainbow
  call minpac#add('luochen1990/rainbow')
  " let g:rainbow_active = 1
  " let g:rainbow_conf = {
  " \  'guifgs': ['#ffd700', '#da70d6', '#87cefa'],
  " \  'operators': '',
  " \  'separately': {
  " \    'html': 0
  " \  }
  " \}

  " Snippets
  call minpac#add('SirVer/ultisnips')
  call minpac#add('adriaanzon/vim-emmet-ultisnips')
  let g:UltiSnipsEditSplit="vertical"
  " let g:UltiSnipsUsePythonVersion = 3
  let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips', 'UltiSnips']
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

  " ALE
  call minpac#add('dense-analysis/ale')
  let g:ale_fix_on_save = 1
  let g:airline#extensions#ale#enabled = 1
  let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
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
  nmap gh <Plug>(ale_hover)
  nmap gd <Plug>(ale_go_to_definition)
  nmap gr <Plug>(ale_find_references)

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
  let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|unit))\.(js|jsx|coffee|ts|tsx|iced)$'
  let g:test#javascript#jest#executable = 'yarn test'
  nnoremap <leader>t :TestNearest<cr>
  nnoremap <leader>T :TestFile<cr>
  nnoremap <leader>a :TestSuite<cr>

  "
  " Languages
  " Most of these are from vim-polyglot
  " (https://github.com/sheerun/vim-polyglot)
  "

  " C improvements
  call minpac#add('vim-scripts/aftersyntaxc.vim')

  " Fish
  call minpac#add('dag/vim-fish')

  " HTML
  call minpac#add('https://notabug.org/jorgesumle/vim-html-syntax')
  let g:html_no_rendering = 1

  " Handlebars
  call minpac#add('mustache/vim-mustache-handlebars')

  " CSS, Less, Sass
  call minpac#add('JulesWang/css.vim')
  call minpac#add('cakebaker/scss-syntax.vim')
  call minpac#add('groenewege/vim-less')
  " Custom rules
  syn region cssFunction contained matchgroup=cssFunctionName start="\<\(minmax\|repeat\)\s*(" end=")" oneline keepend


  " Coffeescript + iced support
  call minpac#add('kchmck/vim-coffee-script')
  autocmd BufNewFile,BufRead *.iced set filetype=coffee

  " JavaScript
  call minpac#add('pangloss/vim-javascript')
  let g:javascript_plugin_jsdoc = 1
  call minpac#add('styled-components/vim-styled-components', {'branch': 'main'})
  call minpac#add('maxmellon/vim-jsx-pretty')

  " TypeScript
  call minpac#add('HerringtonDarkholme/yats.vim')

  " JSON
  call minpac#add('elzr/vim-json')

  " GraphQL
  call minpac#add('jparise/vim-graphql')

  " Markdown
  call minpac#add('plasticboy/vim-markdown')
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_math = 1
  let g:vim_markdown_strikethrough = 1
  let g:vim_markdown_new_list_item_indent = 2
  set conceallevel=2
  " let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'ruby', 'sass', 'xml', 't_space_errors = 0

  " Syntax highlighting for github's hub tool
  call minpac#add('jez/vim-github-hub')

  " Ruby
  call minpac#add('vim-ruby/vim-ruby')
  " Ruby on Rails
  call minpac#add('tpope/vim-rails')
  call minpac#add('tpope/vim-endwise')

  " Go
  " Make sure to call :GoUpdateBinaries on install
  call minpac#add('fatih/vim-go')
  let g:go_gopls_enabled = 0
  let g:go_highlight_extra_types = 1
  let g:go_highlight_functions = 1
  let g:go_def_mapping_enabled = 0

  " Python
  call minpac#add('vim-python/python-syntax')
  let g:python_highlight_all = 1
  let g:go_highlight_function_calls = 1

  " Rust
  call minpac#add('rust-lang/rust.vim')
  " TOML
  call minpac#add('cespare/vim-toml')
  " Scala
  call minpac#add('derekwyatt/vim-scala')
  let g:scala_scaladoc_indent = 1
  " Erlang
  call minpac#add('vim-erlang/vim-erlang-runtime')
  " Avro
  call minpac#add('gurpreetatwal/vim-avro')

  " NERDTree
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')
  " s for sidebar
  map <leader>s :NERDTreeFind<CR>
  call minpac#add('nelstrom/vim-visual-star-search')
  let g:NERDTreeAutoDeleteBuffer = 1
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  let NERDTreeIgnore=['.DS_Store$', '.git/$']

  " call minpac#add('tmsvg/pear-tree')
  let g:pear_tree_smart_openers = 0
  let g:pear_tree_smart_closers = 0
  let g:pear_tree_smart_backspace = 0

  " Deoplete autocompletion
  " call minpac#add('Shougo/deoplete.nvim')
  " let g:deoplete#enable_at_startup = 1
  " autocmd VimEnter * call deoplete#custom#option('sources', {
  " \ '_': ['ale'],
  " \ })
  " https://github.com/Shougo/deoplete.nvim/issues/766#issuecomment-498403969
  " https://github.com/Shougo/deoplete.nvim/issues/298
  " set completeopt-=preview
  " let g:ale_completion_tsserver_autoimport = 1

  call minpac#add('machakann/vim-highlightedyank')

  call minpac#add('junegunn/vim-peekaboo')
  let g:peekaboo_delay = 500
  " let g:peekaboo_compact = 1

  call minpac#add('kana/vim-textobj-user')
  call minpac#add('kana/vim-textobj-entire')

  call minpac#add('andrewradev/splitjoin.vim')
  call minpac#add('AndrewRadev/tagalong.vim')

  call minpac#add('ap/vim-css-color')

  call minpac#add('prabirshrestha/async.vim')
  call minpac#add('prabirshrestha/asyncomplete.vim')
  call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
  call minpac#add('prabirshrestha/vim-lsp')
  call minpac#add('mattn/vim-lsp-settings')
  call minpac#add('thomasfaingnaert/vim-lsp-snippets')
  call minpac#add('thomasfaingnaert/vim-lsp-ultisnips')
  let g:lsp_virtual_text_enabled = 0
  let g:lsp_fold_enabled = 0
  " let g:lsp_preview_float = 0

  nmap gh <plug>(lsp-hover)
  nmap gd <plug>(lsp-declaration)
  " nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
  " nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  " nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  " nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  " nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  " nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  " nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>


else
  colorscheme elflord
endif
