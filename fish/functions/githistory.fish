# Function to handle Ctrl+C gracefully
function on_exit --on-signal SIGINT
  exit 0
end

function githistory --description 'See the history of a repo'
  set commit_hashes (git log --reverse --format="%H")
  for hash in $commit_hashes
    git show --stat --patch $hash
  end
end
