if status --is-login; and status --is-interactive
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual block

    if test -e ~/.config/fish/stripe-config.fish
        source ~/.config/fish/stripe-config.fish
    end
    if command -v rbenv >/dev/null 2>&1
        source (rbenv init -|psub)
    end
    if command -v nodenv >/dev/null 2>&1
        source (nodenv init -|psub)
    end
    if test -e {$HOME}/.iterm2_shell_integration.fish
        source {$HOME}/.iterm2_shell_integration.fish
    end

  # TODO:
  # From 4.0 release notes:
  # > Up-arrow search matches -- which are highlighted in reverse colors -- are no longer syntax-highlighted, to fix bad contrast with the search match highlighting.
  #
  # Restore this behavior

  # TODO: look into `prompt_pwd`
  # TODO: look into `fish_vcs_prompt`

  # ASDF configuration code
  if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
  else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
  end

  # Do not use fish_add_path (added in Fish 3.2) because it
  # potentially changes the order of items in PATH
  if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
  end
  set --erase _asdf_shims


  # Direnv
  direnv hook fish | source
end
