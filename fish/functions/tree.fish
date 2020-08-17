function tree --wraps='tree -I node_modules|__pycache__' --description 'tree, with some default folders to ignore'
  command tree -I "node_modules|__pycache__" $argv;
end
