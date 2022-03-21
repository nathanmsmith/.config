if status --is-login; and status --is-interactive
  set fish_cursor_default     block      blink
  set fish_cursor_insert      line       blink
  set fish_cursor_replace_one underscore blink
  set fish_cursor_visual      block

  set -gx KITTY_LISTEN_ON unix:/tmp/mykitty-(ps -o ppid -p $fish_pid | sed -n '2p')

  # Ruby
  source (rbenv init -|psub)

  # Rust
  set -x PATH $CARGO_HOME/bin $PATH

  # Go
  set -x GOPATH $HOME/Developer/go
  set -x PATH $GOPATH/bin $PATH

  if test -e ~/.config/fish/stripe-config.fish
    source ~/.config/fish/stripe-config.fish
    source (nodenv init -|psub)
  end

  test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
end
