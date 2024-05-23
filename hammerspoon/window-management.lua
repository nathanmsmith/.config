local geometry = require("hs.geometry")

-- Set animation duration
hs.window.animationDuration = 0

-- Ignore headless apps
hs.window.filter.ignoreAlways["Safari Technology Preview Networking"] = true
hs.window.filter.ignoreAlways["Mail Networking"] = true
hs.window.filter.ignoreAlways["Dash Networking"] = true

local log = hs.logger.new("window-manger")
log.setLogLevel(5)
log.i("Initializing")

-- Focus Navigation
-- By app (lowercase)
hs.hotkey.bind({ "alt" }, "h", function()
  local win = hs.window.focusedWindow()
  win:focusWindowWest(nil, true)
end)

hs.hotkey.bind({ "alt" }, "l", function()
  local win = hs.window.focusedWindow()
  win:focusWindowEast(nil, true)
end)

hs.hotkey.bind({ "alt" }, "j", function()
  local win = hs.window.focusedWindow()
  win:focusWindowSouth(nil, true)
end)

hs.hotkey.bind({ "alt" }, "k", function()
  local win = hs.window.focusedWindow()
  win:focusWindowNorth(nil, true)
end)

-- Move app to screen (uppercase)
hs.hotkey.bind({ "alt", "shift" }, "h", function()
  local window = hs.window.focusedWindow()
  window:moveOneScreenWest(true, true)
  window:maximize(true)
end)

hs.hotkey.bind({ "alt", "shift" }, "l", function()
  local window = hs.window.focusedWindow()
  window:moveOneScreenEast(true, true)
  window:maximize(true)
end)

function CreateSplit(layout1, layout2)
  local windows = hs.window.orderedWindows()
  local currentWindow = windows[1]
  log.i("Current window: " .. hs.inspect.inspect(currentWindow))
  windows = hs.fnutils.ifilter(windows, function(window)
    return currentWindow:screen() == window:screen()
  end)
  local prevWindow = windows[2]
  log.i("Prev window: " .. hs.inspect.inspect(prevWindow))
  currentWindow:move(layout1)
  prevWindow:move(layout2)
end

-- Create a vertical split
hs.hotkey.bind({ "alt" }, "v", function()
  log.i("Vertical split")
  CreateSplit(hs.layout.left50, hs.layout.right50)
end)

-- Create a horizontal split
hs.hotkey.bind({ "alt" }, "w", function()
  log.i("Horizontal split")
  local bottom50 = geometry.rect(0, 0.5, 1, 1)
  local top50 = geometry.rect(0, 0, 1, 0.5)
  CreateSplit(top50, bottom50)
end)

-- Fullscreen
hs.hotkey.bind({ "cmd", "alt" }, "f", function()
  local window = hs.window.focusedWindow()
  window:maximize(true)
end)

-- Center
hs.hotkey.bind({ "alt" }, "c", function()
  local window = hs.window.focusedWindow()
  window:centerOnScreen(nil, true)
end)
