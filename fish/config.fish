if status --is-login
  set -gx fish_greeting ""

  switch (uname)
  case Linux
      echo Hi Tux!
      set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
      set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
      set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
      set -g fish_user_paths "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $fish_user_paths;
      set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH;
      set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH;
  case Darwin
      # set -gx PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /usr/local/sbin /usr/local/MacGPG2/bin /Library/TeX/texbin
      # Use GNU utilities instead of macOS versions
      set -gx PATH /usr/local/opt/{coreutils,findutils,grep,gnu-sed,gnu-time,make,gnu-units}/libexec/gnubin $PATH
      # Use Homebrew curl
      set -gx PATH /usr/local/opt/curl/bin $PATH
      # Use installed LLVM tools
      set -gx PATH /usr/local/opt/llvm/bin $PATH
  case '*'
      echo Unknown OS, you may want to add some config!
      uname
  end


  # XDG Directories
  set -gx XDG_CONFIG_HOME $HOME/.config
  # set -gx XDG_CACHE_HOME $HOME/.cache
  # set -gx XDG_DATA_HOME $HOME/.local/share

  # Bootstrap fisher
  # https://github.com/jorgebucaran/fisher
  # if not functions -q fisher
  #     curl https://git.io/fisher --create-dirs -sLo "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
  #     fish -c fisher
  # end

  # Set editor
  set -gx EDITOR nvim

  # FZF
  set -gx FZF_DEFAULT_COMMAND  'rg -g !.git/ --files --hidden'

  # AWS
  set -gx SAM_CLI_TELEMETRY 0

  # Load aliases
  source ~/.config/fish/aliases.fish

  # Load secrets
  # source ~/.config/fish/secrets.fish

  # Force certain more-secure behaviors from homebrew
  set -x HOMEBREW_NO_INSECURE_REDIRECT 1
  set -x HOMEBREW_CASK_OPTS --require-sha
  set -gx HOMEBREW_NO_ANALYTICS 1

  # JavaScript specific settings
  # Set up nodenv
  # if type --no-function --quiet nodenv
  #   status --is-interactive; and nodenv init - | source
  # end

  # Ruby specific settings
  # Rbenv
  # if type --no-function --quiet rbenv
  #   status --is-interactive; and rbenv init - | source
  # end
  set -gx PATH /usr/local/lib/ruby/gems/2.7.0/bin /usr/local/opt/ruby/bin $PATH

  # Go specific settings
  set -gx GOPATH ~/Developer/go
  set -gx PATH $GOPATH/bin $PATH

  # Python settings
  set -gx PATH $HOME/.poetry/bin $PATH
  set -gx PATH /usr/local/opt/python@3.8/bin $PATH
  # if type --no-function --quiet pyenv
  #   status --is-interactive; and pyenv init - | source
  # end
  # Use pyenv's current python version
  set -gx PIPENV_PYTHON /usr/local/opt/python@3.8/bin/python3

  # PySpark
  set -gx PYSPARK_PYTHON /usr/local/opt/python/libexec/bin/python


  # Rust specific settings
  # Rust tools XDG compatibility
  # set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
  # set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup
  set -gx PATH $PATH $CARGO_HOME/bin

  # Io specific settings
  # set -gx EERIEDIR ~/.eerie
  # set -gx PATH $PATH $EERIEDIR/base/bin $EERIEDIR/activeEnv/bin

#   # Keybase development
#   set -e KEYBASE_PERF
#   set -x KEYBASE_LOCAL_DEBUG 1
#   set -x KEYBASE_DEV_TOOL_ROOTS "$HOME/Library/Application Support/Google/Chrome/Default/Extensions/fmkadmapgofadopljbjfkapdkoienihi,$HOME/Library/Application Support/Google/Chrome/Default/Extensions/hgldghadipiblonfkkicmgcbbijnpeog"
#   set -x RUN_MODE devel
#   # set -gx PATH /usr/local/opt/mysql@5.6/bin $PATH
#   # Android
#   # set -x ANDROID_HOME "$HOME/Library/Android/sdk"
#   # set -x PATH $PATH $ANDROID_HOME/tools $ANDROID_HOME/platform-tools $ANDROID_HOME/tools/bin $ANDROID_HOME/emulator

  test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
end
