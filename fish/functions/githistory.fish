# Function to handle Ctrl+C gracefully
# TODO: As of 4.0, I think this is clear-commandline
function on_exit --on-signal SIGINT
  exit 0
end

function githistory --description 'See the history of a repo'
  set commit_hashes (git log --reverse --format="%H")
  for hash in $commit_hashes
    git show --format=medium --date=format:'%A %B %d, %Y @ %I:%M%p' --stat --patch $hash
  end
end
