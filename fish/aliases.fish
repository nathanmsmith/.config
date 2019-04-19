alias tower "gittower ."
alias typora "open -a typora"
# alias macchanger 'openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//" | xargs sudo ifconfig en0 ether'
alias config "cd $XDG_CONFIG_HOME; and $EDITOR $XDG_CONFIG_HOME"
alias wiki "cd ~/wiki; and $EDITOR ~/wiki"

# Abbreviations
# See https://github.com/fish-shell/fish-shell/issues/1976#issuecomment-168698602
# if not set -q abbr_initialized
#   set -U abbr_initialized

  abbr --add cfg 'config'
  abbr --add w 'wiki'

  # Git
  abbr --add g 'git'
  abbr --add ga 'git add'
  abbr --add gad 'git add .'
  abbr --add ga. 'git add .'
  abbr --add gst 'git status'
  abbr --add gbr 'git branch'
  abbr --add gco 'git checkout'
  abbr --add gcm 'git commit -m'
  abbr --add gcma 'git commit -ma'
  abbr --add gbd 'git branch -d'
  abbr --add gbD 'git branch -D'
  abbr --add gp 'git push'
  abbr --add gpf 'git push --force-with-lease'
  abbr --add gpl 'git pull'
  abbr --add gr 'git rebase'
  abbr --add gri 'git rebase --interactive'
  abbr --add gst 'git status'
  abbr --add gd 'git diff'

  # Yarn
  abbr --add yn 'yarn'
  abbr --add yns 'yarn start'
# end
