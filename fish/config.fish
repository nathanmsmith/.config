if status --is-login; and status --is-interactive
  set fish_cursor_default     block      blink
  set fish_cursor_insert      line       blink
  set fish_cursor_replace_one underscore blink
  set fish_cursor_visual      block

  # PATH settings
  # Use ARM native programs if they exist, but prefer intel versions (for compatibility)
  set -x PATH /usr/local/bin /opt/homebrew/bin $PATH
  # GNU utils
  set -x PATH /opt/homebrew/opt/{coreutils,findutils,gnu-time,gnu-units}/libexec/gnubin $PATH
  # Curl
  set -x PATH /opt/homebrew/opt/curl/bin $PATH

  # Use installed LLVM tools
  # set -x PATH /opt/homebrew/opt/llvm/bin $PATH
  # Ruby
  # set -x PATH /opt/homebrew/lib/ruby/gems/2.7.0/bin /opt/homebrew/opt/ruby/bin $PATH

  set -x PATH /usr/local/opt/ruby@2.6/bin /usr/local/lib/ruby/gems/2.6.0/bin $PATH

  set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=/opt/homebrew/opt/openssl@1.1 --with-readline-dir=/opt/homebrew/opt/readline"
  # Rust
  set -x PATH $HOME/.cargo/bin $PATH
  # Go
  set -x GOPATH $HOME/Developer/go
  set -x PATH $GOPATH/bin $PATH
end

# status --is-interactive; and source (rbenv init -|psub)
