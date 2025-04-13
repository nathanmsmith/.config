# Abbreviations
# abbrs are no longer universal, so no need for a check


abbr --add fc fish_config
abbr --add cfg config
abbr --add o open
abbr --add o. 'open .'

# ls/eza
abbr --add l ls
abbr --add la 'ls -a'
abbr --add ll 'ls -lh --header'
abbr --add lla 'ls -lha --header'

abbr --add md 'mkdir -p'
abbr --add rd 'rm -r'

# Homebrew
abbr --add b brew
abbr --add bs 'brew search'
abbr --add bi 'brew info'
abbr --add binst 'brew install'

# Ruby + Rails
abbr --add r rails
abbr --add be 'bundle exec'
abbr --add ber 'bundle exec rails'
abbr --add tc 'bin/typecheck'

# Go
abbr --add got 'go test'
abbr --add gotv 'go test -v'
abbr --add gor 'go run'
abbr --add gob 'go build'

# Make
abbr --add m make
abbr --add mb 'make build'

# Vim
abbr --add v nvim
abbr --add n nvim

# Git
# Mainly inspired by https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet#git
abbr --add g git
abbr --add ga 'git add'
abbr --add gi 'git ignore'
abbr --add ginit 'git init'
abbr --add gad 'git add .'
abbr --add ga. 'git add .'
abbr --add gst 'git status'
abbr --add gbr 'git branch'
abbr --add gcl 'git clone'
abbr --add gco 'git checkout'
abbr --add gcom 'git checkout main'
abbr --add gcob 'git checkout -b $USER/'
abbr --add gco- 'git checkout -'
abbr --add gc 'git commit'
abbr --add gca 'git commit -a'
abbr --add gcm 'git commit -m'
abbr --add gcam 'git commit -am'
abbr --add gbd 'git branch -d'
abbr --add gbD 'git branch -D'
abbr --add gp 'git push'
abbr --add gpu 'git push -u origin HEAD'
abbr --add gpf 'git push --force-with-lease'
abbr --add gf 'git fetch'
abbr --add gpl 'git pull'
abbr --add grh 'git reset HEAD'
abbr --add grb 'git rebase'
abbr --add grbm 'git rebase main'
abbr --add grbi 'git rebase --interactive'
abbr --add grbc 'git rebase --continue'
abbr --add grbs 'git rebase --skip'
abbr --add gd 'git diff'
abbr --add gdm 'git diff main'
abbr --add gds 'git diff --staged'
abbr --add gdc 'git discard'
abbr --add gs 'git sync'
abbr --add gsta 'git stash'
abbr --add gstaa 'git stash --all'
abbr --add gl 'git log --graph'
abbr --add gnpr 'git new-pull-request'
abbr --add gclc 'git commit-last-command'

abbr --add gmt 'git mergetool'
abbr --add gdt 'git difftool'

# Yarn
abbr --add yn yarn
abbr --add yns 'yarn start'
abbr --add ynt 'yarn test'
abbr --add ynb 'yarn build'
abbr --add yna 'yarn add'
abbr --add ynad 'yarn add --dev'
