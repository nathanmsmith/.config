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

end
