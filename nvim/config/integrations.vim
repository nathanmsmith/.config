" integrations.vim
" Configuration for interactions with external programs

let s:uname = trim(system("uname -s"))

" Set Python paths
if s:uname == "Darwin"
  let g:python_host_prog = "/usr/bin/python"
  let g:python3_host_prog = "/usr/local/bin/python3"
  " let g:python_host_prog = "/usr/local/bin/python"
  " let g:python3_host_prog = "/usr/local/opt/python@3.8/bin/python3"
endif

" Open images in an image viewer (probably Preview)
if s:uname == "Darwin"
  autocmd BufEnter *.png,*.jpg,*.gif exec "silent !open ".expand("%") | :bw
endif

" ctags integration with gutentags
call minpac#add('ludovicchabant/vim-gutentags',  {'rev': '31c0ead'})
let g:gutentags_ctags_executable_ruby = 'ripper-tags'
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git', 'vim']
let g:gutentags_ctags_exclude = [
      \  '*.git', '*.svn', '*.hg',
      \  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
      \  '*-lock.json',  '*.lock',
      \  '*.min.*',
      \  '*.bak',
      \  '*.zip',
      \  '*.pyc',
      \  '*.class',
      \  '*.sln',
      \  '*.csproj', '*.csproj.user',
      \  '*.tmp',
      \  '*.cache',
      \  '*.vscode',
      \  '*.pdb',
      \  '*.exe', '*.dll', '*.bin',
      \  '*.mp3', '*.ogg', '*.flac',
      \  '*.swp', '*.swo',
      \  '.DS_Store', '*.plist',
      \  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
      \  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
      \]

" grep with ripgrep
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" Diff Mode
set diffopt+=vertical

" Git
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')

" Unix utilities
call minpac#add('tpope/vim-eunuch')


" Testing with vim-test
call minpac#add('vim-test/vim-test')
let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|unit))\.(js|jsx|coffee|ts|tsx|iced)$'
let g:test#javascript#jest#executable = 'yarn test'
nnoremap <leader>t :TestNearest<cr>
nnoremap <leader>T :TestFile<cr>
nnoremap <leader>a :TestSuite<cr>

" Linter support
" ALE
call minpac#add('dense-analysis/ale')
" let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_javascript_eslint_suppress_missing_config = 1
" let g:ale_prolog_swipl_timeout = 10
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

call minpac#add('neovim/nvim-lsp', {'type': 'opt'})
packadd nvim-lsp

call minpac#add('nvim-lua/lsp-status.nvim', {'type': 'opt'})
call minpac#add('nathunsmitty/diagnostic-nvim', {'type': 'opt'})
call minpac#add('nvim-lua/completion-nvim', {'type': 'opt'})
packadd lsp-status.nvim
packadd diagnostic-nvim
packadd completion-nvim
" LSP config, in lua
lua require("lsp")

setlocal omnifunc=v:lua.vim.lsp.omnifunc
" Show errors after 1 second
set updatetime=1000
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1
" Complete parentheses for functions
let g:completion_enable_auto_paren = 1
" Work with endwise
let g:completion_confirm_key = "\<C-y>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
let g:completion_enable_snippet = 'UltiSnips'

let g:netrw_gx = '<cWORD>'
