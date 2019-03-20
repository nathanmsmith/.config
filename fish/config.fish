if status --is-login
  set -gx fish_greeting ""

  # Set vi bindings
  set -gx fish_key_bindings fish_user_key_bindings

  set -gx FZF_DEFAULT_COMMAND  'rg --files --hidden'

  # Load aliases
  source ~/.config/fish/aliases.fish

  # Load secrets
  source ~/.config/fish/secrets.fish

  # Force certain more-secure behaviors from homebrew
  set -x HOMEBREW_NO_INSECURE_REDIRECT 1
  set -x HOMEBREW_CASK_OPTS --require-sha

  # Use GNU coreutils instead of macOS versions
  set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

  # Use ripgrep for fzf
  set -gx FZF_DEFAULT_COMMAND  'rg --files --hidden'

  # JavaScript specific settings
  # Set up nodenv
  status --is-interactive; and source (nodenv init -|psub)
  # what is memory?
  set -x NODE_OPTIONS "--max-old-space-size=4096"

  # Ruby specific settings
  # Rbenv
  status --is-interactive; and source (rbenv init -|psub)
  # Add gems to path
  set -gx PATH $PATH /usr/local/lib/ruby/gems/2.6.0/bin

  # Go specific settings
  # GOPATH
  set -gx GOPATH $HOME/Developer/go
  # Add locally compiled go programs to bin	  # DD Stuff
  set -gx PATH $PATH $GOPATH/bin

  source ~/.config/fish/datadog.fish

  # DD Stuff
  # Add datadog devtools binaries to the PATH
  set -x PATH "$HOME/dd/devtools/bin:$PATH"

  # Point DATADOG_ROOT to ~/dd symlink
  set -x DATADOG_ROOT "$HOME/dd"

  # Tell the devenv vm to mount $GOPATH/src rather than just dd-go
  set -x MOUNT_ALL_GO_SRC 1

  # store key in the login keychain instead of aws-vault managing a hidden keychain
  set -x AWS_VAULT_KEYCHAIN_NAME login

  # tweak session times so you don't have to re-enter passwords every 5min
  set -x AWS_SESSION_TTL 24h
  set -x AWS_ASSUME_ROLE_TTL 1h
  set -x VAGRANT_CWD $DATADOG_ROOT
  set -x DEVENV_MEM 8192
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
