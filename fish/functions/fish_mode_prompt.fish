# Fish mode prompt doesn't play nicely with having a newline before the prompt, see
# https://github.com/fish-shell/fish-shell/issues/4746
# Since fish updates the cursor, that's good enough for me to determine mode.
function fish_mode_prompt; end

# A more fully featured mode prompt, if I ever want to go back to it:
# function fish_mode_prompt
  # # Do nothing if not in vi mode
  # if test "$fish_key_bindings" = fish_vi_key_bindings
  #   or test "$fish_key_bindings" = fish_hybrid_key_bindings

  #   switch $fish_bind_mode
  #     case default
  #       set_color --bold red
  #       echo -n '🅽'
  #     case insert
  #       set_color --bold green
  #       echo -n '🅸'
  #     case replace_one
  #       set_color --bold green
  #       echo -n '🆁'
  #     case replace
  #       set_color --bold cyan
  #       echo -n '🆁'
  #     case visual
  #       set_color --bold magenta
  #       echo -n '🆅'
  #   end
  #   set_color normal
  #   echo -n ' '
  # end
# end
