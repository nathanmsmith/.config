if status --is-login; and status --is-interactive
  set fish_cursor_default     block      blink
  set fish_cursor_insert      line       blink
  set fish_cursor_replace_one underscore blink
  set fish_cursor_visual      block

  # PATH settings
  # Use ARM native programs if they exist, but prefer intel versions (for compatibility)
  set -x PATH /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin  $PATH
  # GNU utils
  set -x PATH /opt/homebrew/opt/{coreutils,findutils,gnu-time,gnu-units}/libexec/gnubin $PATH
  # Curl
  set -x PATH /opt/homebrew/opt/curl/bin $PATH

  # Use python 3.8
  # set -x PATH /opt/homebrew/opt/python@3.8/bin $PATH

  # Use installed LLVM tools
  set -x PATH /opt/homebrew/opt/llvm/bin $PATH
  # Ruby
  source (rbenv init -|psub)
  # set -x PATH /opt/homebrew/lib/ruby/gems/2.7.0/bin /opt/homebrew/opt/ruby/bin $PATH
  # set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=/opt/homebrew/opt/openssl@1.1 --with-readline-dir=/opt/homebrew/opt/readline"

  # set -gx LDFLAGS "-L/opt/homebrew/opt/ruby/lib"
  # set -gx CPPFLAGS "-I/opt/homebrew/opt/ruby/include"

  # Rust
  set -x PATH $CARGO_HOME/bin $PATH

  # Go
  set -x PATH $GOPATH/bin $PATH

  if test -e ~/.config/fish/stripe-config.fish
    source ~/.config/fish/stripe-config.fish
    source (nodenv init -|psub)
  end

  test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
end

