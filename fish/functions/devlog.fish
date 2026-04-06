function devlog -d "Open devlog in Neovim"
    if has_stripe_config
        cd ~/stripe/devlog
    else
        cd ~/Developer/devlog
    end
    nvim +Devlog
end
