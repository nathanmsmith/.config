set fish_greeting ""

# Set vi bindings
set fish_key_bindings fish_user_key_bindings

# Load aliases
source ~/.config/fish/aliases.fish

# Go (Keybase)
set -x GOPATH $HOME/Developer/go
set -x PATH $GOPATH/bin $PATH # Dev Keybase before Official Release
# set -gx PATH $PATH /usr/local/opt/go@1.9/libexec/bin

# Feature Flags
set -x KEYBASE_FEATURES "admin"

# Android (Keybase)
set -x ANDROID_HOME "$HOME/Library/Android/sdk"

# Keybase
set -e KEYBASE_PERF
set -x KEYBASE_LOCAL_DEBUG 1
set -x KEYBASE_DEV_TOOL_ROOTS "$HOME/Library/Application Support/Google/Chrome/Default/Extensions/fmkadmapgofadopljbjfkapdkoienihi,$HOME/Library/Application Support/Google/Chrome/Default/Extensions/hgldghadipiblonfkkicmgcbbijnpeog"
set -x KEYBASE_RUN_MODE prod  # KBFS

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# set -g fish_user_paths "/usr/local/opt/go@1.9/bin" $fish_user_paths