set fish_greeting ""

# TODO: use -U option

# Set vi bindings
set fish_key_bindings fish_user_key_bindings

# Load aliases
source ~/.config/fish/aliases.fish

# More secure homebrew settings
set -x HOMEBREW_NO_INSECURE_REDIRECT 1
set -x HOMEBREW_CASK_OPTS --require-sh

# Use GNU coreutils instead of macOS versions
# set -x /usr/local/opt/coreutils/libexec/gnubin:$PATH

# GOPATH
set -x GOPATH $HOME/Developer/go

# Opam configuration
source /Users/nathan/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
