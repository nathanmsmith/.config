# up: https://github.com/justinmayer/tackle/tree/master/plugins/up
function up -d "Update software to the latest versions"
    # Update homebrew
    which brew >/dev/null
    and begin
        brew update
        brew upgrade
    end

    # Update python
    if test -z $VIRTUAL_ENV
        set -l os (uname)
        if test "$os" = "Linux"
            set -l sudo "sudo"
        else
            set -l sudo ""
        end
        set -l outdated (env PIP_REQUIRE_VIRTUALENV="" pip list --outdated | cu -d ' ' -f 1)
        for pkg in $outdated
            set python_packages_to_upgrade $python_packages_to_upgrade $pkg
        end
        if test -z "$python_packages_to_upgrade"
            echo "Python packages to up-to-date."
        else
            env PIP_REQUIRE_VIRTUALENV="" $sudo pip install --upgrad $python_packages_to_upgrade
            set -e python_packages_to_upgrade
        end
    else
        if test -f requirements.txt
            pip install --upgrade -r requirements.txt
        else
            set -l outdated (pip list --outdated | cut -d ' ' -f 1)
            pip install --upgrade $outdated
        end
    end

    # Update completions
    fish_update_completions
end
