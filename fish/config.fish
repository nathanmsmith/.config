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
  set -gx PATH /usr/local/opt/{coreutils,findutils,grep,gnu-sed,make}/libexec/gnubin $PATH
  set -gx PATH /usr/local/opt/gettext/bin $PATH

  # Use installed LLVM tools
  set -gx PATH /usr/local/opt/llvm/bin $PATH

  # JavaScript specific settings
  # Set up nodenv
  # Note: We don't need psub here like nodenv reccomends
  status --is-interactive; and nodenv init - | source

  # Ruby specific settings
  # Rbenv
  status --is-interactive; and rbenv init - | source
  set -gx PATH /usr/local/opt/ruby/bin $PATH

  # Go specific settings
  set -gx GOPATH ~/Developer/go
  set -gx PATH $GOPATH/bin $PATH

  # Rust specific settings
  # Rust tools XDG compatibility
  # set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
  # set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup

  set -gx PATH $PATH $CARGO_HOME/bin

  # Io specific settings
  set -gx EERIEDIR ~/.eerie
  set -gx PATH $PATH $EERIEDIR/base/bin $EERIEDIR/activeEnv/bin

  # Keybase development
  set -e KEYBASE_PERF
  set -x KEYBASE_LOCAL_DEBUG 1
  set -x KEYBASE_DEV_TOOL_ROOTS "$HOME/Library/Application Support/Google/Chrome/Default/Extensions/fmkadmapgofadopljbjfkapdkoienihi,$HOME/Library/Application Support/Google/Chrome/Default/Extensions/hgldghadipiblonfkkicmgcbbijnpeog"
  set -x RUN_MODE devel
  set -gx PATH /usr/local/opt/mysql@5.6/bin $PATH
  # Android
  set -x ANDROID_HOME "$HOME/Library/Android/sdk"
  set -x PATH $PATH $ANDROID_HOME/tools $ANDROID_HOME/platform-tools $ANDROID_HOME/tools/bin $ANDROID_HOME/emulator

end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
