if set -q PATH_INITIALIZED; and test (uname) = Darwin
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -Ux GOPATH $HOME/Developer/go

    fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin
    fish_add_path /opt/homebrew/opt/{coreutils,findutils,diffutils,gnu-time,gnu-units,gnu-sed,gnu-awk,gnu-tar}/libexec/gnubin
    fish_add_path /opt/homebrew/opt/python/libexec/bin
    fish_add_path /opt/homebrew/opt/curl/bin
    fish_add_path /opt/homebrew/opt/llvm/bin
    fish_add_path /opt/homebrew/opt/postgresql@17/bin
    fish_add_path $HOME/.rbenv/bin
    fish_add_path $PYENV_ROOT/bin
    fish_add_path $CARGO_HOME/bin
    fish_add_path $GOPATH/bin
    fish_add_path ~/.local/share/nvim/mason/bin/

    set -Ux PATH_INITIALIZED 1
end
