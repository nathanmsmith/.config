# Custom fish keybindings
function fish_user_key_bindings -d "Custom keybindings"
  fish_vi_key_bindings

  bind -M default a backward-char
  bind -M default e forward-char
  bind , up-or-search
  bind o down-or-search
end
