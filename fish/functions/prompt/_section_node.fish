function _section_node -d "Display the local node version"

  if not test -f ./package.json -o -d ./node_modules
    return
  end
