# Defined in - @ line 1
function ls --wraps=eza --description 'alias ls eza'
    eza --time-style '+%Y-%m-%d %I:%M%P' $argv
end
