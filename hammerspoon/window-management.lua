-- spaces = require("hs._asm.undocumented.spaces")
-- Modal window management
-- Set animation duration
hs.window.animationDuration = 0

halfApps = {"Dash", "Soulver"}

appWatcher = hs.application.watcher.new(function(appName, eventType, app)
  if eventType == hs.application.watcher.deactivated then
    prevApp = appName
  elseif eventType == hs.application.watcher.activated then
    local layout = hs.layout.maximized
    -- currentWindow = hs.window.frontmostWindow()
    local windows = hs.window.orderedWindows()
    print(hs.inspect.inspect(windows))
    if appName == "Dash" then
      local prevWindow = windows[2]
      print(hs.inspect.inspect(prevWindow))
      prevWindow:move(hs.layout.left50)
      layout = hs.layout.right50
    end

    local win = app:mainWindow()
    if win ~= nil then
      win:move(layout)
    end
  end
end)
appWatcher:start()
appWatcher:stop()


hs.grid.setMargins({0, 0})
hs.grid.setGrid('24x18')

-- k=hs.hotkey.modal.new({"alt"}, "tab")
-- function k:entered()
--   hs.alert.show("Entered window mode", _, _, 0)
-- end
-- function k:exited()
--   hs.alert.show("Exited window mode", _, _, 0)
-- end

function temorarilyDisableAppWatcher()
  appWatcher:stop()
  hs.timer.doAfter(60, function()
    appWatcher:start()
  end)
end

mod = {"alt"}

hs.hotkey.bind(mod, "m", function()
  local win = hs.window.focusedWindow()
  win:move(hs.layout.maximized)
  hs.grid.snap(win)
  temorarilyDisableAppWatcher()
end)

hs.hotkey.bind(mod, "h", function()
  local win = hs.window.focusedWindow()
  win:move(hs.layout.left50)
  hs.grid.snap(win)
  temorarilyDisableAppWatcher()
end)

hs.hotkey.bind(mod, "l", function()
  local win = hs.window.focusedWindow()
  win:move(hs.layout.right50)
  hs.grid.snap(win)
  temorarilyDisableAppWatcher()
end)

hs.hotkey.bind(mod, "w", function()
  appWatcher:stop()
end)
hs.hotkey.bind({"alt", "shift"}, "w", function()
  appWatcher:start()
end)

-- TODO: H 75/25
--       L 25/75
