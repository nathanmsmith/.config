function ibrew --wraps='arch -x86_64 brew' --description 'alias for intel homebrew'
    arch -x86_64 /usr/local/bin/brew $argv
end
