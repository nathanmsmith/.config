-- spaces = require("hs._asm.undocumented.spaces")
-- Modal window management
-- Set animation duration
hs.window.animationDuration = 0

ignoreApps = {"iStat Menus Status", "Fantastical Helper"}
centerApps = {"System Preferences", "Dictionary"}
halfApps = {"Dash", "Soulver"}
secondaryApps = {"Spotify", "Slack"}

appWatcher = hs.application.watcher.new(function(appName, eventType, app)
  print(appName)
  if eventType == hs.application.watcher.activated then
    if hs.fnutils.contains(ignoreApps, appName) then
      return
    end

    if hs.fnutils.contains(centerApps, appName) then
      local window = hs.window.find(appName)
      window:centerOnScreen()
      return
    end

    local layout = hs.layout.maximized

    if hs.fnutils.contains(halfApps, appName) then
      local appWindows = app:allWindows()
      local allWindows = hs.window.orderedWindows()
      local filteredWindows = hs.fnutils.filter(allWindows, function(window)
        return not hs.fnutils.contains(appWindows, window)
      end)
      print(hs.inspect.inspect(filteredWindows))

      local prevWindow = filteredWindows[1]

      print(hs.inspect.inspect(windows))
      print(prevWindow)
      prevWindow:move(hs.layout.left50)
      layout = hs.layout.right50
    end

    local win = app:mainWindow()

    if hs.fnutils.contains(secondaryApps, appName) and #hs.screen.allScreens() > 1 then
      local secondaryScreen = hs.screen("Color LCD")
      win:moveToScreen(secondaryScreen, false, true)
    end

    if win ~= nil then
      win:move(layout)
    end


  end
end)
appWatcherEnabled = true
appWatcher:start()

hs.grid.setMargins({0, 0})
hs.grid.setGrid('24x18')

function temorarilyDisableAppWatcher()
  if appWatcherEnabled then
    appWatcher:stop()
    hs.timer.doAfter(60, function()
      appWatcher:start()
    end)
  end
end

mod = {"alt", "cmd"}

-- Left/Right Navigation
-- By app (lowercase)
hs.hotkey.bind({"alt"}, "h", function()
  local win = hs.window.focusedWindow()
  win:focusWindowWest(nil, true)
end)

hs.hotkey.bind({"alt"}, "l", function()
  local win = hs.window.focusedWindow()
  win:focusWindowEast(nil, true)
end)

-- By screen (uppercase)
-- hs.hotkey.bind({"alt", "shift"}, "h", function()
--   local win = hs.window.focusedWindow()
--   win:focusWindowWest(nil, true)
-- end)

-- hs.hotkey.bind({"alt"}, "l", function()
--   local win = hs.window.focusedWindow()
--   win:focusWindowEast(nil, true)
-- end)


-- Create a vertical split
hs.hotkey.bind({"alt"}, "v", function()
  local windows = hs.window.orderedWindows()
  local currentWindow = windows[1]
  local prevWindow = windows[2]
  currentWindow:move(hs.layout.left50)
  prevWindow:move(hs.layout.right50)
  temorarilyDisableAppWatcher()
end)

-- Fullscreen
hs.hotkey.bind({"alt"}, "f", function()
  local window = hs.window.focusedWindow()
  window:maximize(true)
end)

-- Toggle Watcher
appWatcherIcon = hs.menubar.new()
function setAppWatcherIcon(state)
  if state then
    appWatcherIcon:setTitle("AUTO")
  else
    appWatcherIcon:setTitle("DISABLED")
  end
end

function toggleAppWatcher()
  if appWatcherEnabled then
    appWatcherEnabled = false
    appWatcher:stop()
  else
    appWatcherEnabled = true
    appWatcher:start()
  end
  setAppWatcherIcon(appWatcherEnabled)
end

hs.hotkey.bind({"alt"}, "w", toggleAppWatcher)

if appWatcherIcon then
  appWatcherIcon:setClickCallback(toggleAppWatcher)
  setAppWatcherIcon(appWatcherEnabled)
end



-- TODO: H 75/25
--       L 25/75
