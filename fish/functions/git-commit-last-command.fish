# Commit the last command run.
# Example usage:
# > bin/run generate-files
# > commit-last-command
# --> "git add ."
function git-commit-last-command --wraps="git commit"
  set last_command (history | head -1)
  git add .
  git commit -m "$last_command" $argv
end
