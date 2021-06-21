###-begin-sls-completion-###
function _sls_completion
  set cmd (commandline -o)
  set cursor (commandline -C)
  set words (node -pe "'$cmd'.split(' ').length")

  set completions (eval env DEBUG=\"" \"" COMP_CWORD=\""$words\"" COMP_LINE=\""$cmd \"" COMP_POINT=\""$cursor\"" sls completion -- $cmd)

  for completion in $completions
    echo -e $completion
  end
end

complete -f -d 'sls' -c sls -a "(eval _sls_completion)"
###-end-sls-completion-###
