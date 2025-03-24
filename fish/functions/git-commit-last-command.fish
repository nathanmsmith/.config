# Commit the last command run.
# Example usage:
# > bin/run generate-files
# > commit-last-command
# --> "git add ."
function git-commit-last-command --wraps="git commit"
  set last_command (history | head -1)
  if test "$last_command" = "git commit-last-command" -o "$last_command" = "git-commit-last-command"
    # Go back one more
    set last_command (history | head -2 | tail -1)
  end


  git add .
  git commit -m "$last_command" $argv
end
