set fish_greeting ""

# TODO: use -U option

# Set vi bindings
set fish_key_bindings fish_user_key_bindings

# Load aliases
source ~/.config/fish/aliases.fish


# BEGIN ANSIBLE MANAGED BLOCK
# Add homebrew binaries to the path.
set PATH "/usr/local/bin:$PATH"

# Force certain more-secure behaviours from homebrew
set HOMEBREW_NO_INSECURE_REDIRECT 1
set HOMEBREW_CASK_OPTS --require-sha

# Prefer GNU binaries to Macintosh binaries.
set PATH "/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Add datadog devtools binaries to the PATH
set PATH "HOME/dd/devtools/bin:$PATH"

# Point GOPATH to our go sources
set GOPATH "HOME/go"

# Point DATADOG_ROOT to ~/dd symlink
set DATADOG_ROOT "HOME/dd"

# Tell the devenv vm to mount $GOPATH/src rather than just dd-go
set MOUNT_ALL_GO_SRC 1

# store key in the login keychain instead of aws-vault managing a hidden keychain
set AWS_VAULT_KEYCHAIN_NAME login

# tweak session times so you don't have to re-enter passwords every 5min
set AWS_SESSION_TTL 24h
set AWS_ASSUME_ROLE_TTL 1h
# END ANSIBLE MANAGED BLOCK⏎                                                    
# Nodenv
status --is-interactive; and source (nodenv init -|psub)

# Rbenv
status --is-interactive; and source (rbenv init -|psub)

