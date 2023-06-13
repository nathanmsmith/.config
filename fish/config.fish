if status --is-login; and status --is-interactive
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual block

    # Ruby
    source (rbenv init -|psub)

    # Node
    source (nodenv init -|psub)

    if test -e ~/.config/fish/stripe-config.fish
        source ~/.config/fish/stripe-config.fish
    end

    fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin
    fish_add_path /opt/homebrew/opt/{coreutils,findutils,diffutils,gnu-time,gnu-units,gnu-sed,gnu-awk,gnu-tar}/libexec/gnubin
    fish_add_path /opt/homebrew/opt/curl/bin
    fish_add_path /opt/homebrew/opt/llvm/bin
    fish_add_path $HOME/.rbenv/bin
    fish_add_path $PYENV_ROOT/bin
    fish_add_path $CARGO_HOME/bin
    fish_add_path /opt/homebrew/opt/python/libexec/bin
    fish_add_path ~/.local/share/nvim/mason/bin/


    test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
end
