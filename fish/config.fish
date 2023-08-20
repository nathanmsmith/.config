if status --is-login; and status --is-interactive
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual block

    if test -e ~/.config/fish/stripe-config.fish
        source ~/.config/fish/stripe-config.fish
    end

    source (rbenv init -|psub)
    source (nodenv init -|psub)

    test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
end
