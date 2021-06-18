" Plugins
" Package manager: vim-packager, https://github.com/kristijanhusak/vim-packager

function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
  call packager#local()

  " Git
  call packager#add('tpope/vim-fugitive')
  call packager#add('tpope/vim-rhubarb')
  call packager#add('airblade/vim-gitgutter')
  call packager#add('rhysd/conflict-marker.vim')

  " Marks
  call packager#add('kshenoy/vim-signature')

  " ctags
  call packager#add('ludovicchabant/vim-gutentags')


  call packager#add('norcalli/nvim-colorizer.lua', {'type': 'opt'})
  call packager#add('junegunn/vim-peekaboo')
  call packager#add('nelstrom/vim-visual-star-search')

  " Tim Pope Essentials
  call packager#add('tpope/vim-commentary')
  call packager#add('tpope/vim-surround')
  call packager#add('tpope/vim-repeat')
  call packager#add('tpope/vim-unimpaired')
  " Helpful character metadata on `ga`
  call packager#add('tpope/vim-characterize')
  " Ctrl-a, ctrl-x for dates, times, etc.
  call packager#add('tpope/vim-speeddating')
  " Add readline bindings for command line mode
  call packager#add('tpope/vim-rsi')
  " Substitution and Coercion
  call packager#add('tpope/vim-abolish')

  " Text object modifications and extensions
  call packager#add('chaoren/vim-wordmotion')
  call packager#add('wellle/targets.vim')
  call packager#add('kana/vim-textobj-user')
  call packager#add('kana/vim-textobj-entire')
  call packager#add('nelstrom/vim-textobj-rubyblock')
  call packager#add('whatyouhide/vim-textobj-xmlattr')

  " Snippets
  call packager#add('SirVer/ultisnips')

  " Completion
  call packager#add('ervandew/supertab')

  " Unix utilities
  call packager#add('tpope/vim-eunuch')
  " Enhance netrw
  call packager#add('tpope/vim-vinegar')

  call packager#add('vim-test/vim-test')
  call packager#add('dense-analysis/ale')
  call packager#add('tpope/vim-projectionist')
  call packager#add('srstevenson/vim-picker')

  call packager#add('AndrewRadev/splitjoin.vim')


  " LSP
  call packager#add('neovim/nvim-lspconfig', {'type': 'opt'})
  call packager#local('~/Developer/vim-packages/nvim-ale-diagnostic', {'type': 'opt'})
  call packager#add('tjdevries/nlua.nvim', {'type': 'opt'})

  " Treesitter
  call packager#add('nvim-treesitter/nvim-treesitter', {'type': 'opt'})
  call packager#add('nvim-treesitter/nvim-treesitter-textobjects', {'type': 'opt'})
  call packager#add('nvim-treesitter/playground', {'type': 'opt'})

  call packager#add('fatih/vim-go', { 'do': ':GoInstallBinaries'})
  " Syntax highlighting for github's hub tool
  call packager#add('jez/vim-github-hub')
  " Fish
  call packager#add('dag/vim-fish')
  " Handlebars
  call packager#add('mustache/vim-mustache-handlebars')
  " EJS
  call packager#add('briancollins/vim-jst')
  " CSS, Less, Sass
  call packager#add('cakebaker/scss-syntax.vim')
  call packager#add('groenewege/vim-less')
  " JavaScript
  call packager#add('pangloss/vim-javascript')
  call packager#add('styled-components/vim-styled-components', {'branch': 'main'})
  call packager#add('maxmellon/vim-jsx-pretty')
  " TypeScript
  call packager#add('HerringtonDarkholme/yats.vim')
  " Svelte
  call packager#add('evanleck/vim-svelte')
  " JSON
  call packager#add('elzr/vim-json')
  " TOML
  call packager#add('cespare/vim-toml')
  " GraphQL
  call packager#add('jparise/vim-graphql')
  " Ruby/Rails
  call packager#add('vim-ruby/vim-ruby')
  call packager#add('tpope/vim-rails')
  call packager#add('tpope/vim-endwise')
  call packager#add('tpope/vim-rake')
  call packager#add('tpope/vim-bundler')
  " Rust
  call packager#add('rust-lang/rust.vim')
  " Python
  call packager#add('vim-python/python-syntax')
  " Elixir
  call packager#add('elixir-editors/vim-elixir')
  " Terraform
  call packager#add('hashivim/vim-terraform')
  " Nginx
  call packager#add('chr4/nginx.vim')
endfunction


command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()
