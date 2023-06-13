function git_nosys --wraps=git --description 'GIT_CONFIG_NOSYSTEM=1 git'
    env GIT_CONFIG_NOSYSTEM=1 git $argv
end
