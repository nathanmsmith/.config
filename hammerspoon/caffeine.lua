-- Caffeine
CaffeineMenubarItem = hs.menubar.new()

-- Set the icon of the menubar.
function SetCaffeineDisplay(state)
  if state then
    CaffeineMenubarItem:setIcon("images/active.pdf")
  else
    CaffeineMenubarItem:setIcon("images/inactive.pdf")
  end
end

-- Click the menubar icon, which toggles the caffeine state and menubar icon.
function MenubarClicked()
  SetCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

-- Turns the caffeine state to off.
function CaffeineOff()
  hs.caffeinate.set("displayIdle", false, true)
  SetCaffeineDisplay(false)
end

-- Introduce url event for toggling caffeine state.
hs.urlevent.bind("caffeine-toggle", function()
  SetCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end)

if CaffeineMenubarItem then
  -- Initialize callback
  CaffeineMenubarItem:setClickCallback(MenubarClicked)

  -- Initialize display to current displayIdle value
  SetCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

function OnSleepWatcher(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    CaffeineOff()
  end
end

SleepWatcher = hs.caffeinate.watcher.new(OnSleepWatcher)
SleepWatcher:start()
