set fish_greeting ""

# TODO: use -U option

# Set vi bindings
set fish_key_bindings fish_user_key_bindings

# Load aliases
source ~/.config/fish/aliases.fish

# Load secrets
source ~/.config/fish/secrets.fish

# BEGIN ANSIBLE MANAGED BLOCK
# Add homebrew binaries to the path.
set -x PATH "/usr/local/bin:$PATH"

# Force certain more-secure behaviours from homebrew
set -x HOMEBREW_NO_INSECURE_REDIRECT 1
set -x HOMEBREW_CASK_OPTS --require-sha

set -x NODE_OPTIONS "--max-old-space-size=4096"

# Prefer GNU binaries to Macintosh binaries.
set -x PATH "/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Add datadog devtools binaries to the PATH
set -x PATH "$HOME/dd/devtools/bin:$PATH"

# Point GOPATH to our go sources
set -x GOPATH "$HOME/go"

# Point DATADOG_ROOT to ~/dd symlink
set -x DATADOG_ROOT "$HOME/dd"

# Tell the devenv vm to mount $GOPATH/src rather than just dd-go
set -x MOUNT_ALL_GO_SRC 1

# store key in the login keychain instead of aws-vault managing a hidden keychain
set -x AWS_VAULT_KEYCHAIN_NAME login

# tweak session times so you don't have to re-enter passwords every 5min
set -x AWS_SESSION_TTL 24h
set -x AWS_ASSUME_ROLE_TTL 1h
# END ANSIBLE MANAGED BLOCK⏎                                           
set -x VAGRANT_CWD $DATADOG_ROOT
set -x DEVENV_MEM 8192

# Nodenv
status --is-interactive; and source (nodenv init -|psub)

# Rbenv
status --is-interactive; and source (rbenv init -|psub)

