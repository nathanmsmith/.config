function m4b-tool
    docker run -it --rm -u (id -u):(id -g) -v "$PWD":/mnt sandreas/m4b-tool:latest $argv
end
