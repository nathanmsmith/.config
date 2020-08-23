function get-identifier --description 'Get an app identifier'
  osascript -e "id of app \"$argv\""
end
