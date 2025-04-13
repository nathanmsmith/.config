if not set -q $PATH_INITIALIZED; and test (uname) = Linux
    fish_add_path ~/.local/share/nvim/mason/bin/

    set -Ux PATH_INITIALIZED 1
end
