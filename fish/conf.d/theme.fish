# Auto-apply Night Owl theme if not already set
if status is-interactive
    if test "$fish_terminal_color_theme" != "night-owl"
        fish_config theme choose night-owl
    end
end
