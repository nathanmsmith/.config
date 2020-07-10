" Nathan Smith's vim configuration

" Overarching Philosophy:
" 1. Prefer the defaults
" 2. Extend functionality where needed
" 3. Change functionality only when it doesn't make sense

" Reset the cursor on exit
" See https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
" and https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
" set guicursor=a:blinkon100
:au VimLeave,VimSuspend * set guicursor=a:ver25-blinkon1

" Map leader to space
let mapleader = " "

" Color Defaults
" set background=dark
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

" Don't redraw for macros
set lazyredraw

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

" Mouse support
" Useful for things like resizing windows
if has('mouse')
  set mouse=a
end

" make Y consistent with C and D.
nnoremap Y y$

" grep with ripgrep
" https://github.com/BurntSushi/ripgrep
" if executable('rg')
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m
" endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
" Copied from defaults.vim)
" See :h restore-cursor
" TODO: There seems to be a bug where this happens for git commits too, so
" disabling this for now.
" autocmd VimEnter *
  " \ if line("'\"") >= 1 && line("'\"") <= line("$") " && &ft != 'gitcommit'
  " " \ |   exe "normal! g`\""
  " \ | endif

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

let s:uname = trim(system("uname -s"))
" Python support
if s:uname == "Darwin"
  let g:python_host_prog = "/usr/local/bin/python"
  let g:python3_host_prog = "/usr/local/opt/python@3.8/bin/python3"
endif

if s:uname == "Darwin"
  autocmd BufEnter *.png,*.jpg,*.gif exec "silent !open ".expand("%") | :bw
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
try
  packadd minpac

  command! PacInstall source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
  command! PacClean source $MYVIMRC | call minpac#clean()
  command! PacStatus source $MYVIMRC | call minpac#status()
catch
  fun! InstallPlug() " Bootstrap plugin manager on new systems. Copied from https://github.com/justinmk/config/blob/master/.config/nvim/init.vim#L19
    exe '!git clone https://github.com/k-takata/minpac.git ' stdpath('config').'/pack/minpac/opt/minpac'
    " call minpac#update()
  endfun
endtry

if exists('*minpac#init')
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Color Scheme
  call minpac#add('nathunsmitty/night-owl.vim')
  colorscheme night-owl

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
  lua require("projectionist")

  " Substitution and Coercion
  call minpac#add('tpope/vim-abolish')
  " Let's call it PascalCase, not MixedCase
  nmap crp crm
  " Also kebabcase
  nmap cr- crk

  " Handle swap files better
  " call minpac#add('gioele/vim-autoswap')
  " let g:autoswap_detect_tmux = 1

  " Better definitions of a word
  " TODO: an update seems to have made this buggy, fix
  " call minpac#add('chaoren/vim-wordmotion')
  " CamelCaseWord->followed_by_snake_case

   " Fuzzy finding with vim-picker
   " I've found it to be faster that the default fzf plugin.
   " fzf is much better than selecta, fzy, etc. though
   " ripgrep has the fastest search
   call minpac#add('srstevenson/vim-picker')
   nnoremap <silent> <leader>p :PickerEdit<CR>
   let g:picker_custom_find_executable = 'rg'
   let g:picker_custom_find_flags = '-g !.git/ --files --hidden --color never'
   let g:picker_selector_executable = 'fzf'
   let g:picker_selector_flags = '--layout=reverse'
   let g:picker_height = 14

  " Rainbow Parentheses
  " There are many different plugins out there for rainbow parentheses, this one is the most
  " maintained.
  " refs: https://github.com/luochen1990/rainbow
  " call minpac#add('luochen1990/rainbow')
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
\}
  let g:ale_javascript_eslint_suppress_missing_config = 1
  let g:ale_prolog_swipl_timeout = 10
  nmap <silent> [W <Plug>(ale_first)
  nmap <silent> [w <Plug>(ale_previous)
  nmap <silent> ]w <Plug>(ale_next)
  nmap <silent> ]W <Plug>(ale_last)
  nmap gh <Plug>(ale_hover)
  nmap gd <Plug>(ale_go_to_definition)
  nmap gr <Plug>(ale_find_references)

  " vim-test
  call minpac#add('vim-test/vim-test')
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

  " C++ improvements
  call minpac#add('octol/vim-cpp-enhanced-highlight')

  " Fish
  call minpac#add('dag/vim-fish')

  " HTML
  call minpac#add('https://notabug.org/jorgesumle/vim-html-syntax')
  let g:html_no_rendering = 1
  " Misc HTML Templating Lanugages
  " Handlebars
  call minpac#add('mustache/vim-mustache-handlebars')
  " EJS
  call minpac#add('briancollins/vim-jst')

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
  call minpac#add('tpope/vim-markdown')
  " call minpac#add('plasticboy/vim-markdown')
  " let g:vim_markdown_folding_disabled = 1
  " let g:vim_markdown_frontmatter = 1
  " let g:vim_markdown_math = 1
  " let g:vim_markdown_strikethrough = 1
  " let g:vim_markdown_new_list_item_indent = 2
  " set conceallevel=2
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
  " m conflicts with vim-signature
  let NERDTreeMapMenu='n'

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

  call minpac#add('christoomey/vim-tmux-navigator')
  autocmd VimResized * :wincmd =

  call minpac#add('lervag/vimtex')
  let g:tex_conceal = 0

  call minpac#add('tommcdo/vim-exchange')
  call minpac#add('fvictorio/vim-textobj-backticks')

  call minpac#add('kshenoy/vim-signature')

  call minpac#add('tpope/vim-fireplace', {'type': 'opt'})

  call minpac#add('tpope/vim-rsi')

  call minpac#add('chaoren/vim-wordmotion')
  let g:wordmotion_spaces = '_-.'

  call minpac#add('wellle/targets.vim')

  call minpac#add('prabirshrestha/asyncomplete.vim')
  call minpac#add('prabirshrestha/vim-lsp')
  call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
  call minpac#add('mattn/vim-lsp-settings')
  let g:lsp_signs_enabled = 1         " enable signs
  let g:lsp_diagnostics_enabled = 1

  " Getting no results with echos or floats
  " let g:lsp_diagnostics_echo_delay = 0
  " let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
  " let g:lsp_diagnostics_float_cursor = 1
  " let g:lsp_diagnostics_float_delay = 0
  let g:lsp_virtual_text_enabled = 1
  let g:lsp_virtual_text_prefix = "  ‣ "
  let g:lsp_highlight_references_enabled = 0
  let g:lsp_fold_enabled = 0

else
  colorscheme elflord
endif

command! DumbQuotes %s/“\|”/"/g | %s/‘\|’/'/g


set title
setglobal titlestring=nvim
set colorcolumn=+1

" Add current directory to path
set path+=.,,

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> gh <plug>(lsp-hover)

  " refer to doc to add more commands
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
