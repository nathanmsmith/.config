# Defined in - @ line 1
function ls --wraps=eza --description 'alias ls eza'
    if command -q eza
        eza --time-style '+%Y-%m-%d %I:%M%P' $argv
    else
        command ls $argv
    end
end
