function tree --wraps='exa --tree -I node_modules|__pycache__' --description 'tree, with some default folders to ignore'
  command exa --tree -I "node_modules|__pycache__" $argv;
end
