# Defined in - @ line 1
function config --wraps='cd ~/.config' --description 'alias config cd ~/.config'
  cd ~/.config $argv;
end
