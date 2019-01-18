# Custom fish keybindings
function fish_user_key_bindings -d "Custom keybindings"
  fish_vi_key_bindings

  bind -M default h backward-char
  bind -M default s forward-char
  bind n up-or-search
  bind t down-or-search
end
