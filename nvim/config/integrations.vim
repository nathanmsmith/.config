" integrations.vim
" Configuration for interactions with external programs


" Set Python paths
let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/local/bin/python3"

" Open images in an image viewer (probably Preview)
autocmd BufEnter *.png,*.jpg,*.gif exec "silent !open ".expand("%") | :bw

" ctags integration with gutentags
" call minpac#add('ludovicchabant/vim-gutentags',  {'rev': '31c0ead'})
" let g:gutentags_ctags_executable_ruby = 'ripper-tags'
" let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git', 'vim']
" let g:gutentags_ctags_exclude = [
"       \  '*.git', '*.svn', '*.hg',
"       \  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
"       \  '*-lock.json',  '*.lock',
"       \  '*.min.*',
"       \  '*.bak',
"       \  '*.zip',
"       \  '*.pyc',
"       \  '*.class',
"       \  '*.sln',
"       \  '*.csproj', '*.csproj.user',
"       \  '*.tmp',
"       \  '*.cache',
"       \  '*.vscode',
"       \  '*.pdb',
"       \  '*.exe', '*.dll', '*.bin',
"       \  '*.mp3', '*.ogg', '*.flac',
"       \  '*.swp', '*.swo',
"       \  '.DS_Store', '*.plist',
"       \  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
"       \  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
"       \  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
"       \]

" grep with ripgrep
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" Diff Mode
set diffopt+=vertical

" Testing with vim-test
let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|unit))\.(js|jsx|coffee|ts|tsx|iced)$'
let g:test#javascript#jest#executable = 'yarn test'
nnoremap <leader>t :TestNearest<cr>
nnoremap <leader>T :TestFile<cr>
nnoremap <leader>a :TestSuite<cr>

" Linter support
" ALE
let g:ale_disable_lsp = 1
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
