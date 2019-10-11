alias tower "gittower ."
alias typora "open -a typora"
# alias macchanger 'openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//" | xargs sudo ifconfig en0 ether'
alias config "cd $XDG_CONFIG_HOME; and $EDITOR $XDG_CONFIG_HOME"
alias wiki "cd ~/wiki; and $EDITOR ~/wiki"

# Abbreviations
# See https://github.com/fish-shell/fish-shell/issues/1976#issuecomment-168698602
# if not set -q abbr_initialized
#   set -U abbr_initialized

abbr --add --global cfg 'config'
abbr --add --global w 'wiki'

abbr --add --global o 'open .'

# ls
abbr --add --global l 'ls'
abbr --add --global la 'ls -a'
abbr --add --global ll 'ls -l'
abbr --add --global lla 'ls -la'

abbr --add --global md 'mkdir -p'
abbr --add --global rd 'rm -r'

# Homebrew --global
abbr --add --global b 'brew'
abbr --add --global bc 'brew cask'
abbr --add --global bs 'brew search'
abbr --add --global bi 'brew info'
abbr --add --global bist 'brew install'

# Docker

# Go
abbr --add --global got 'go test'
abbr --add --global gotv 'go test -v'
abbr --add --global gor 'go run'
abbr --add --global gob 'go build'


# Make
abbr --add --global m 'make'
abbr --add --global mb 'make build'

# Vim
abbr --add v 'nvim'
abbr --add n 'nvim'

# Git
# Mainly inspired by https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet#git
abbr --add --global g 'git'
abbr --add --global ga 'git add'
abbr --add --global gi 'git ignore'
abbr --add --global ginit 'git init'
abbr --add --global gad 'git add .'
abbr --add --global ga. 'git add .'
abbr --add --global gst 'git status'
abbr --add --global gbr 'git branch'
abbr --add --global gcl 'git clone'
abbr --add --global gco 'git checkout'
abbr --add --global gcom 'git checkout master'
abbr --add --global gco- 'git checkout -'
abbr --add --global gc 'git commit'
abbr --add --global gca 'git commit -a'
abbr --add --global gcm 'git commit -m'
abbr --add --global gcam 'git commit -am'
abbr --add --global gbd 'git branch -d'
abbr --add --global gbD 'git branch -D'
abbr --add --global gp 'git push'
abbr --add --global gpu 'git push -u origin'
abbr --add --global gpf 'git push --force-with-lease'
abbr --add --global gf 'git fetch'
abbr --add --global gpl 'git pull'
abbr --add --global grh 'git reset HEAD'
abbr --add --global grb 'git rebase'
abbr --add --global grbm 'git rebase master'
abbr --add --global grbi 'git rebase --interactive'
abbr --add --global grbc 'git rebase --continue'
abbr --add --global grbs 'git rebase --skip'
abbr --add --global gst 'git status'
abbr --add --global gd 'git diff'
abbr --add --global gds 'git diff --staged'
abbr --add --global gdc 'git discard'
abbr --add --global gs 'git stash'
abbr --add --global gsa 'git stash --all'
abbr --add --global gl 'git log'

abbr --add --global gmt 'git mergetool'
abbr --add --global gdt 'git difftool'

abbr --add --global gnpr 'git new-pull-request'

# Yarn
abbr --add --global yn 'yarn'
abbr --add --global yns 'yarn start'
abbr --add --global ynt 'yarn test'
abbr --add --global ynb 'yarn build'
abbr --add --global yna 'yarn add'
abbr --add --global ynad 'yarn add --dev'
# Keybase specific
abbr --add --global ynsh 'yarn start-hot'
abbr --add --global ynhs 'yarn hot-server'
abbr --add --global ynst 'yarn storybook'
abbr --add --global ynrnst 'yarn rn-storybook'
abbr --add --global ynrns 'yarn rn-start'
abbr --add --global ynrnsi 'yarn rn-start ios'
abbr --add --global ynts 'yarn test story --silent'
abbr --add --global yntsu 'yarn test story --silent -u'

# Keybase

abbr --add --global kb 'keybase'
abbr --add --global kbc 'keybase chat'
abbr --add --global kbw 'keybase wallet'
abbr --add --global kbwa 'keybase wallet api'

# end
