packadd vim-rails
packadd vim-endwise
packadd vim-rake
packadd vim-bundler
" packadd vim-textobj-rubyblock

let b:ale_fixers = ['rufo', 'rubocop']
let b:ale_linters = ['ruby', 'rubocop']

let b:ale_ruby_rubocop_executable = 'bundle'
