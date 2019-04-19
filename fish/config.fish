if status --is-login
  set -gx fish_greeting ""

  # Bootstrap fisher
  # https://github.com/jorgebucaran/fisher
  if not functions -q fisher
      set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
      curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
      fish -c fisher
  end

  # Set vi bindings
  set -gx fish_key_bindings fish_user_key_bindings

  # Set editor
  set -gx EDITOR nvim

  # FZF
  set -gx FZF_DEFAULT_COMMAND  'rg -g !.git/ --files --hidden'
  set -gx FZF_LEGACY_KEYBINDINGS 0

  # Load aliases
  source ~/.config/fish/aliases.fish

  # Load secrets
  source ~/.config/fish/secrets.fish

  # Force certain more-secure behaviors from homebrew
  set -x HOMEBREW_NO_INSECURE_REDIRECT 1
  set -x HOMEBREW_CASK_OPTS --require-sha

  # Use GNU utilities instead of macOS versions
  set -gx PATH /usr/local/opt/{coreutils,grep,gnu-sed}/libexec/gnubin $PATH

  # Use install LLVM tools
  set -gx PATH /usr/local/opt/llvm/bin $PATH

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
  set -gx GOPATH $HOME/go
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
