#!/usr/local/bin/fish

alias config "cd ~/.config"
alias ls "exa"
# alias macchanger 'openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//" | xargs sudo ifconfig en0 ether'

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
abbr --add bc 'brew cask'
abbr --add bci 'brew cask info'
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
abbr --add ra 'rails'

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
abbr --add gcom 'git checkout master'
abbr --add gco- 'git checkout -'
abbr --add gc 'git commit'
abbr --add gca 'git commit -a'
abbr --add gcm 'git commit -m'
abbr --add gcam 'git commit -am'
abbr --add gbd 'git branch -d'
abbr --add gbD 'git branch -D'
abbr --add gp 'git push'
abbr --add gpu 'git push -u origin'
abbr --add gpf 'git push --force-with-lease'
abbr --add gf 'git fetch'
abbr --add gpl 'git pull'
abbr --add grh 'git reset HEAD'
abbr --add grb 'git rebase'
abbr --add grbm 'git rebase master'
abbr --add grbi 'git rebase --interactive'
abbr --add grbc 'git rebase --continue'
abbr --add grbs 'git rebase --skip'
abbr --add gd 'git diff'
abbr --add gds 'git diff --staged'
abbr --add gdc 'git discard'
abbr --add gs 'git sync'
abbr --add gsta 'git stash'
abbr --add gstaa 'git stash --all'
abbr --add gl 'git log'
abbr --add gnpr 'git new-pull-request'

abbr --add gmt 'git mergetool'
abbr --add gdt 'git difftool'

abbr --add gnpr 'git new-pull-request'

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
# AWS SAM
set -U SAM_CLI_TELEMETRY 0
# Homebrew
set -U HOMEBREW_NO_INSECURE_REDIRECT 1
set -U HOMEBREW_CASK_OPTS --require-sha
set -U HOMEBREW_NO_ANALYTICS 1
# FZF
set -U FZF_DEFAULT_COMMAND 'rg -g !.git/ --files --hidden'

# XDG CONFIG
set -U XDG_CONFIG_HOME $HOME/.config
