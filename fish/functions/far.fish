function far --description "Find and replace all files from the current directory" --wraps 'sd'
  sd $argv (fd --type file)
end
