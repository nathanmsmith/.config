# The default fish_vi_cursor doesn't seem to work with iTerm 2
# See https://github.com/fish-shell/fish-shell/issues/1403#issuecomment-397109051
function fish_vi_cursor --on-variable fish_bind_mode
    if set -q __last_fish_bind_mode
        and test $__last_fish_bind_mode = $fish_bind_mode
        return
    end
    set -g __last_fish_bind_mode $fish_bind_mode
    switch $fish_bind_mode
        case insert
            printf '\e]50;CursorShape=1\x7'
        case default
            printf '\e]50;CursorShape=0\x7'
        case "*"
            printf '\e]50;CursorShape=0\x7'
    end
end
