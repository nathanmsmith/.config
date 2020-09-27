function poke --description 'Touch, but it makes directories'
  set -l filename basename $argv
  set -l directoryname dirname $argv
  mkdir -p $directoryname && touch filename
end
