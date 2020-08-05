" Languages
" Most of these are from vim-polyglot
" (https://github.com/sheerun/vim-polyglot)
" Language plugin config should go in the appropriate ftplugin file

" Syntax highlighting for github's hub tool
call minpac#add('jez/vim-github-hub')

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

" Svelte
call minpac#add('evanleck/vim-svelte')

" JSON
call minpac#add('elzr/vim-json')
" TOML
call minpac#add('cespare/vim-toml')


" call minpac#add('lervag/vimtex')
" let g:tex_conceal = 0

" GraphQL
call minpac#add('jparise/vim-graphql')


" Ruby
call minpac#add('vim-ruby/vim-ruby')
" Ruby on Rails
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-rake')
call minpac#add('tpope/vim-bundler')

call minpac#add('nelstrom/vim-textobj-rubyblock')

" Rust
call minpac#add('rust-lang/rust.vim')
" Scala
call minpac#add('derekwyatt/vim-scala')
let g:scala_scaladoc_indent = 1
" Erlang
call minpac#add('vim-erlang/vim-erlang-runtime')
" Avro
call minpac#add('gurpreetatwal/vim-avro')


" Go
" Make sure to call :GoUpdateBinaries on install
call minpac#add('fatih/vim-go')
let g:go_gopls_enabled = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_function_calls = 1

" Python
call minpac#add('vim-python/python-syntax')
let g:python_highlight_all = 1
