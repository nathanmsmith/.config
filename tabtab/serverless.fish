###-begin-serverless-completion-###
function _serverless_completion
  set cmd (commandline -o)
  set cursor (commandline -C)
  set words (node -pe "'$cmd'.split(' ').length")

  set completions (eval env DEBUG=\"" \"" COMP_CWORD=\""$words\"" COMP_LINE=\""$cmd \"" COMP_POINT=\""$cursor\"" serverless completion -- $cmd)

  for completion in $completions
    echo -e $completion
  end
end

complete -f -d 'serverless' -c serverless -a "(eval _serverless_completion)"
###-end-serverless-completion-###
