if status --is-login
  set -gx fish_greeting ""

  # XDG Directories
  set -gx XDG_CONFIG_HOME $HOME/.config
  # set -gx XDG_CACHE_HOME $HOME/.cache
  # set -gx XDG_DATA_HOME $HOME/.local/share

  # Bootstrap fisher
  # https://github.com/jorgebucaran/fisher
  if not functions -q fisher
      curl https://git.io/fisher --create-dirs -sLo "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
      fish -c fisher
  end

  # Set vi bindings
  set -gx fish_key_bindings fish_user_key_bindings

  # Set editor
  set -gx EDITOR nvim

  # FZF
  set -gx FZF_DEFAULT_COMMAND  'rg -g !.git/ --files --hidden'

  # Load aliases
  source ~/.config/fish/aliases.fish

  # Load secrets
  # source ~/.config/fish/secrets.fish

  # Force certain more-secure behaviors from homebrew
  set -x HOMEBREW_NO_INSECURE_REDIRECT 1
  set -x HOMEBREW_CASK_OPTS --require-sha
  set -gx HOMEBREW_NO_ANALYTICS 1

  # Use GNU utilities instead of macOS versions
  set -gx PATH /usr/local/opt/{coreutils,findutils,grep,gnu-sed}/libexec/gnubin $PATH

  # Use installed LLVM tools
  set -gx PATH /usr/local/opt/llvm/bin $PATH

  # JavaScript specific settings
  # Set up nodenv
  # Note: We don't need psub here like nodenv reccomends
  status --is-interactive; and nodenv init - | source

  # Ruby specific settings
  # Rbenv
  status --is-interactive; and rbenv init - | source

  # Go specific settings
  # GOPATH
  set -gx GOPATH ~/Developer/go
  set -gx PATH $PATH $GOPATH/bin

  # Rust specific settings
  # Rust tools XDG compatibility
  # set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
  # set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup

  set -gx PATH $PATH $CARGO_HOME/bin

  # Io specific settings
  set -gx EERIEDIR ~/.eerie
  set -gx PATH $PATH $EERIEDIR/base/bin $EERIEDIR/activeEnv/bin

end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/sls.fish ]; and . /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/sls.fish
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/slss.fish ]; and . /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/slss.fish