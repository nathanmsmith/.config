function far --description "Find and replace all files from the current directory" --wraps sd
    for f in (rg $argv[1] -l)
        sd $argv $f
    end
end
