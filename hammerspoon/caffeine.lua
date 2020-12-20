-- Caffeine
caffeineMenubarItem = hs.menubar.new()

-- Set the icon of the menubar.
function setCaffeineDisplay(state)
  if state then
    caffeineMenubarItem:setIcon("images/active.pdf")
  else
    caffeineMenubarItem:setIcon("images/inactive.pdf")
  end
end

-- Click the menubar icon, which toggles the caffeine state and menubar icon.
function menubarClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

-- Turns the caffeine state to off.
function caffeineOff()
  hs.caffeinate.set("displayIdle", false, true)
  setCaffeineDisplay(false)
end

-- Introduce url event for toggling caffeine state.
hs.urlevent.bind("caffeine-toggle", function()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end)

if caffeineMenubarItem then
  -- Initialize callback
  caffeineMenubarItem:setClickCallback(menubarClicked)

  -- Initialize display to current displayIdle value
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
