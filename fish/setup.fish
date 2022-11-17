#!/usr/bin/env /opt/homebrew/bin/fish

# Abbreviations
# See https://github.com/fish-shell/fish-shell/issues/1976#issuecomment-168698602
# if not set -q abbr_initialized
#   set -U abbr_initialized

abbr --add cfg 'config'
abbr --add o 'open'
abbr --add o. 'open .'

# ls/exa
abbr --add l 'ls'
abbr --add la 'ls -a'
abbr --add ll 'ls -lh --header'
abbr --add lla 'ls -lha --header'

abbr --add md 'mkdir -p'
abbr --add rd 'rm -r'

# Homebrew --global
abbr --add b 'brew'
abbr --add bs 'brew search'
abbr --add bi 'brew info'
abbr --add binst 'brew install'

# Docker

# Go
abbr --add got 'go test'
abbr --add gotv 'go test -v'
abbr --add gor 'go run'
abbr --add gob 'go build'

# Ruby
# Rails
abbr --add r 'rails'
abbr --add be 'bundle exec'
abbr --add ber 'bundle exec rails'

# Make
abbr --add m 'make'
abbr --add mb 'make build'

# Vim
abbr --add v 'nvim'
abbr --add n 'nvim'

# Git
# Mainly inspired by https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet#git
abbr --add g 'git'
abbr --add ga 'git add'
abbr --add gi 'git ignore'
abbr --add ginit 'git init'
abbr --add gad 'git add .'
abbr --add ga. 'git add .'
abbr --add gst 'git status'
abbr --add gbr 'git branch'
abbr --add gcl 'git clone'
abbr --add gco 'git checkout'
abbr --add gcom 'git checkout (git main-branch)'
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
abbr --add grbm 'git rebase (git main-branch)'
abbr --add grbi 'git rebase --interactive'
abbr --add grbc 'git rebase --continue'
abbr --add grbs 'git rebase --skip'
abbr --add gd 'git diff'
abbr --add gdm 'git diff (git main-branch)'
abbr --add gds 'git diff --staged'
abbr --add gdc 'git discard'
abbr --add gs 'git sync'
abbr --add gsta 'git stash'
abbr --add gstaa 'git stash --all'
abbr --add gl 'git log --graph'
abbr --add gnpr 'git new-pull-request'

abbr --add gmt 'git mergetool'
abbr --add gdt 'git difftool'

# Yarn
abbr --add yn 'yarn'
abbr --add yns 'yarn start'
abbr --add ynt 'yarn test'
abbr --add ynb 'yarn build'
abbr --add yna 'yarn add'
abbr --add ynad 'yarn add --dev'

# Keybase
abbr --add kb 'keybase'
abbr --add kbc 'keybase chat'
abbr --add kbw 'keybase wallet'
abbr --add kbwa 'keybase wallet api'

# Fish Greeting
# -------------
set -U fish_greeting

# Application configuration
# -------------------------
# Path
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin
fish_add_path /opt/homebrew/opt/{coreutils,findutils,diffutils,gnu-time,gnu-units,gnu-sed,gnu-awk,gnu-tar}/libexec/gnubin
fish_add_path /opt/homebrew/opt/curl/bin
fish_add_path /opt/homebrew/opt/llvm/bin
fish_add_path $HOME/.rbenv/bin
fish_add_path $PYENV_ROOT/bin
fish_add_path $CARGO_HOME/bin
fish_add_path /opt/homebrew/opt/python/libexec/bin

set -Ux EDITOR nvim
# AWS SAM
set -Ux SAM_CLI_TELEMETRY 0
# Homebrew
set -Ux HOMEBREW_NO_INSECURE_REDIRECT 1
set -Ux HOMEBREW_CASK_OPTS --require-sha
set -Ux HOMEBREW_NO_ANALYTICS 1
set -Ux HOMEBREW_NO_AUTO_UPDATE 1

# Prettierd
set -Ux PRETTIERD_LOCAL_PRETTIER_ONLY 1

# Go
set -Ux GOPATH $HOME/Developer/go
fish_add_path $GOPATH/bin

# FZF
set -Ux FZF_DEFAULT_COMMAND 'rg -g !.git/ --files --hidden'
set -Ux FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

# XDG CONFIG
set -Ux XDG_CONFIG_HOME $HOME/.config
# IRB
set -Ux IRBRC "$XDG_CONFIG_HOME"/irb/irbrc

# For Rails projects so that they don't get confused locally
set -Ux DD_TRACE_ENABLED false

if test -e ~/.config/fish/stripe-setup.fish
  source ~/.config/fish/stripe-setup.fish
end
