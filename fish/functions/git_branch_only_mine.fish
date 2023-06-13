function git_branch_only_mine
    git config --add remote.origin.fetch "+refs/heads/$USER-*:refs/remotes/origin/$USER-*"
    git config --add remote.origin.fetch "+refs/heads/$USER/*:refs/remotes/origin/$USER/*"
    git config --add remote.origin.fetch "+refs/heads/master:refs/remotes/origin/master"
    git config --add remote.origin.fetch "+refs/heads/master-passing-tests:refs/remotes/origin/master-passing-tests"
    git config --unset remote.origin.fetch "heads/\*"
    git for-each-ref --format='"%(refname)"' refs/remotes/ | xargs -n1 git update-ref -d && git fetch
end
