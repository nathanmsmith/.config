function tree --wraps='eza --tree -I node_modules|__pycache__' --description 'tree, with some default folders to ignore'
    command eza --tree -I "node_modules|__pycache__" $argv
end
