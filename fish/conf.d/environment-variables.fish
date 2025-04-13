if not set -q $ENV_VARS_INITIALIZED
    set -U fish_greeting

    # Editor
    set -Ux EDITOR nvim

    # AWS SAM
    set -Ux SAM_CLI_TELEMETRY 0

    # Homebrew
    set -Ux HOMEBREW_NO_INSECURE_REDIRECT 1
    set -Ux HOMEBREW_CASK_OPTS --require-sha
    set -Ux HOMEBREW_NO_ANALYTICS 1

    # Prettierd
    set -Ux PRETTIERD_LOCAL_PRETTIER_ONLY 1

    # FZF
    set -Ux FZF_DEFAULT_COMMAND 'rg -g !.git/ --files --hidden'
    set -Ux FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

    # XDG CONFIG
    set -Ux XDG_CONFIG_HOME $HOME/.config

    # IRB
    set -Ux IRBRC "$XDG_CONFIG_HOME"/irb/irbrc

    # For Rails projects so that they don't get confused locally
    set -Ux DD_TRACE_ENABLED false

    set -U ENV_VARS_INITIALIZED 1
end
