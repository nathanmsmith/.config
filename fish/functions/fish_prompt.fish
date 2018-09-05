function _directory -d "Writes the colorized present working directory"
  echo -s 'in ' (set_color --bold cyan) (prompt_pwd) (set_color normal)
end

function _node -d "Writes the node version if there is a package.json"
  if test -f ./package.json
    echo -s 'via ' (set_color --bold green) '⬢ ' (node -v) (set_color normal)
  end
end

function _git_status -d "Writes the current git status, if there is one."
  set -l branch_name (command git rev-parse --abbrev-ref HEAD ^/dev/null)
  if test -z $branch_name
    return
  end

  echo -s (set_color normal) " on "
  if test -z (command git status --porcelain ^/dev/null)
    set_color --bold green
  else
    set_color --bold red
  end
  echo -s $branch_name (set_color normal)

  if test -z (git cherry -v ^/dev/null)
    return
  end

  echo -s " with " (set_color --bold magenta) "unpushed" (set_color normal)

end

function _vim_mode -d "Writes the current vim mode"
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        set_color --bold red
        echo -n 🅽
      case insert
        set_color --bold green
        echo -n 🅸
      case replace_one
        set_color --bold green
        echo -n 🆁
      case visual
        set_color --bold brmagenta
        echo -n 🆅
    end
    echo " "
    set_color normal
  end
end

function fish_prompt -d "Write out the prompt"
  echo -nes "\n" (_vim_mode) (_directory) (_git_status) (_node) '\n› '
end
