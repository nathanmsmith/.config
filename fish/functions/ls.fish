# Defined in - @ line 1
function ls --wraps=exa --description 'alias ls exa'
  if type -q exa
    exa $argv
  else
    ls $argv
  end
end
