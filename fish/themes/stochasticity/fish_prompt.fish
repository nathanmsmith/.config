# Based of the Entropy prompt theme, by Justin Mayer <http://justinmayer.com/> and Zach Holman's <https://zachholman.com> prompt
function fish_prompt -d "Write out the prompt"

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_virtualenv_color
        set -g __fish_prompt_virtualenv_color (set_color --bold yellow)
    end

    if not set -q __fish_prompt_userhost_color
        set -g __fish_prompt_userhost_color (set_color blue)
    end

    if not set -q __fish_prompt_repo_dirty
        set -g __fish_prompt_repo_dirty (set_color --bold red)
    end

    if not set -q __fish_prompt_repo_clean
        set -g __fish_prompt_repo_clean (set_color --bold green)
    end
	
    if not set -q __fish_prompt_need_push
        set -g __fish_prompt_need_push (set_color --bold magenta)
    end

    if not set -q __fish_prompt_gray
        set -g __fish_prompt_gray (set_color -o black)
    end

    # If vcprompt detects PWD is a git/hg repo, call native VCS prompt function
    set -g __vcsystem (vcprompt -f "%n")

    if test -z $__vcsystem
        set -g __vcprompt
		set -g __need_push
    else
        switch $__vcsystem
            case 'git*'
				set -l index (git status --porcelain ^/dev/null)
				if test -z "$index"
					set -g __vcprompt $__fish_prompt_normal' on '$__fish_prompt_repo_clean(__fish_git_prompt "%s" | sed 's/ //')
				else
					set -g __vcprompt $__fish_prompt_normal' on '$__fish_prompt_repo_dirty(__fish_git_prompt "%s" | sed 's/ //')
				end
				
				
				set -l push_index (git cherry -v ^/dev/null)
				if test -z "$push_index"
					set -g __need_push
				else
					set -g __need_push $__fish_prompt_normal" with "$__fish_prompt_need_push"unpushed"
				end	
        end
    end

    switch $USER

        case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end
        end

        set -g __fish_prompt_char '# '

        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color --bold cyan)
        end

        set -g __fish_prompt_char '› '

    end

    if [ -z $SSH_CONNECTION ]

        if not set -q __fish_prompt_userhost
            set -g __fish_prompt_userhost
        end

    else

        if not set -q __fish_prompt_userhost
            set -g __fish_prompt_userhost $__fish_prompt_userhost_color$USER"@"$__fish_prompt_hostname" "
        end

    end

    if set -q VIRTUAL_ENV
        if not set -q __fish_prompt_virtualenv
            set __fish_prompt_virtualenv $__fish_prompt_virtualenv_color"("(basename "$VIRTUAL_ENV")")"$__fish_prompt_normal" "
        end
    end

    echo -n -s \n"$__fish_prompt_userhost" "$__fish_prompt_virtualenv" "in " "$__fish_prompt_cwd" (prompt_pwd) "$__vcprompt" "$__need_push" "$__fish_prompt_normal"\n"$__fish_prompt_char"

end
