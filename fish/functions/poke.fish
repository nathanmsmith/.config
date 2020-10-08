function poke --description 'Touch, but it makes directories too'
  set -l dirpath (dirname $argv)
  mkdir -p $dirpath && touch $argv
end
