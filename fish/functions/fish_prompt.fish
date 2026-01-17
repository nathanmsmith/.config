function _user_host_name -d "Displays the user and host name if connected via SSH"
    if test -n "$SSH_TTY"
        switch "$USER"
            case root toor
                set user_color red
            case '*'
                set user_color yellow
        end
        echo -s (set_color --bold $user_color) $USER (set_color normal) ' at ' (set_color --bold blue) (prompt_hostname) (set_color normal) ' '
    end
end

function _directory -d "Writes the colorized present working directory"
    echo -s 'in ' (set_color --bold cyan) (prompt_pwd) (set_color normal)
end

function _git_status -d "Writes the current git status, if there is one."
    # Check if we're in a git repo
    set -l branch_name (__fish_git_prompt "%s" 2>/dev/null)
    if test -z "$branch_name"
        return
    end

    echo -s (set_color normal) " on "

    # Check dirty state manually for color decision
    set -l dirty (command git status --porcelain 2>/dev/null)
    if test -z "$dirty"
        set_color --bold green
    else
        set_color --bold red
    end
    echo -s (string trim $branch_name) (set_color normal)

    # Check for unpushed commits using optimized git command
    # Use git rev-list --count which is faster than git cherry
    set -l unpushed (command git rev-list --count @{upstream}..HEAD 2>/dev/null)
    if test -n "$unpushed" -a "$unpushed" -gt 0
        echo -s " with " (set_color --bold magenta) unpushed (set_color normal)
    end
end

function fish_prompt -d "Write out the prompt"
    echo -nes "\n" (_user_host_name) (_directory) (_git_status) '\n› '
end
