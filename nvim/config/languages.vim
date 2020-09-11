" Languages
" Most of these are from vim-polyglot
" (https://github.com/sheerun/vim-polyglot)
" Language plugin config should go in the appropriate ftplugin file

" Syntax highlighting for github's hub tool
call minpac#add('jez/vim-github-hub')
" Fish
call minpac#add('dag/vim-fish')
" Handlebars
call minpac#add('mustache/vim-mustache-handlebars')
" EJS
call minpac#add('briancollins/vim-jst')
" CSS, Less, Sass
call minpac#add('cakebaker/scss-syntax.vim')
call minpac#add('groenewege/vim-less')
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
" GraphQL
call minpac#add('jparise/vim-graphql')
" Ruby
call minpac#add('vim-ruby/vim-ruby')
" Ruby on Rails
call minpac#add('tpope/vim-rails', {'type': 'opt'})
call minpac#add('tpope/vim-endwise', {'type': 'opt'})
call minpac#add('tpope/vim-rake', {'type': 'opt'})
call minpac#add('tpope/vim-bundler', {'type': 'opt'})
call minpac#add('nelstrom/vim-textobj-rubyblock', {'type': 'opt'})
" Rust
call minpac#add('rust-lang/rust.vim')
" Go
" Make sure to call :GoUpdateBinaries on install
let g:go_gopls_enabled = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_function_calls = 1
" Python
call minpac#add('vim-python/python-syntax')
let g:python_highlight_all = 1
" Elixir
call minpac#add('elixir-editors/vim-elixir')
