hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Hyper key
hyper = { "ctrl", "alt", "cmd" }
shift_hyper = { "shift", "ctrl", "alt", "cmd" }

-- Caffeine
caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
  if state then
    caffeine:setIcon("images/active.pdf")
  else
    caffeine:setIcon("images/inactive.pdf")
  end
end

function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

hs.urlevent.bind("caffeine-toggle", function()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end)

if caffeine then
  caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

-- Defeat paste blocking
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

-- Always route play/pause to Spotify
-- Inspired by https://github.com/Hammerspoon/Spoons/blob/master/Source/HighSierraiTunesMediaFix.spoon/init.lua
function mediaKeyCallback(event)
  local delete = false

  local data = event:systemKey()

  if data["down"] == false or data["repeat"] == true then
    if data["key"] == "PLAY" then
      hs.spotify.playpause()
      delete = true
    elseif data["key"] == "FAST" then
      hs.spotify.next()
      delete = true
    elseif data["key"] == "REWIND" then
      hs.spotify.previous()
      delete = true
    end
  end

  return delete, nil
end

hs.eventtap.new({hs.eventtap.event.types.NSSystemDefined}, mediaKeyCallback)

-- Window Hints
hs.hints.hintChars = {'a', 'o', 'e', 'u', 'i', 'd', 'h', 't', 'n', 's'}
-- hs.hints.style = 'vimperator'
hs.hotkey.bind(hyper, 'h', function()
  hs.hints.windowHints()
end)

-- Modal window management
-- Set animation duration
hs.window.animationDuration = 0
hs.grid.setMargins({0, 0})
hs.grid.setGrid('24x18')

k=hs.hotkey.modal.new({"alt"}, "tab")
function k:entered()
  hs.alert.show("Entered window mode", _, _, 0)
end
function k:exited()
  hs.alert.show("Exited window mode", _, _, 0)
end


k:bind({}, "space", function()
  local win = hs.window.focusedWindow()
  win:move(hs.layout.maximized)
  hs.grid.snap(win)
end)

k:bind({}, "up", function()
  local win = hs.window.focusedWindow()
  hs.grid.pushWindowUp(win)
end)
k:bind({}, "down", function()
  local win = hs.window.focusedWindow()
  hs.grid.pushWindowDown(win)
end)
k:bind({}, "left", function()
  local win = hs.window.focusedWindow()
  hs.grid.pushWindowLeft(win)
end)
k:bind({}, "right", function()
  local win = hs.window.focusedWindow()
  hs.grid.pushWindowRight(win)
end)

-- CTRL: shrink windows
k:bind({"ctrl"}, "up", function()
  local win = hs.window.focusedWindow()
  hs.grid.resizeWindowShorter(win)
end)
k:bind({"ctrl"}, "down", function()
  local win = hs.window.focusedWindow()
  hs.grid.pushWindowDown(win)
  hs.grid.resizeWindowShorter(win)
end)
k:bind({"ctrl"}, "left", function()
  local win = hs.window.focusedWindow()
  hs.grid.resizeWindowThinner(win)
end)
k:bind({"ctrl"}, "right", function()
  local win = hs.window.focusedWindow()
  hs.grid.pushWindowRight(win)
  hs.grid.resizeWindowThinner(win)
end)

-- OPTION: grow windows
k:bind({"alt"}, "up", function()
  local win = hs.window.focusedWindow()
  hs.grid.pushWindowUp(win)
  hs.grid.pushWindowUp(win)
  hs.grid.resizeWindowTaller(win)
end)
k:bind({"alt"}, "down", function()
  local win = hs.window.focusedWindow()
  hs.grid.resizeWindowTaller(win)
end)
k:bind({"alt"}, "left", function()
  local win = hs.window.focusedWindow()
  hs.grid.pushWindowLeft(win)
  hs.grid.pushWindowLeft(win)
  hs.grid.resizeWindowWider(win)
end)
k:bind({"alt"}, "right", function()
  local win = hs.window.focusedWindow()
  hs.grid.resizeWindowWider(win)
end)

k:bind({"cmd"}, "up", function()
  local win = hs.window.focusedWindow()
  win:move({0,0,1,0.5})
  hs.grid.snap(win)
end)
k:bind({"cmd"}, "down", function()
  local win = hs.window.focusedWindow()
  win:move({0,0.5,1,0.5})
  hs.grid.snap(win)
end)
k:bind({"cmd"}, "left", function()
  local win = hs.window.focusedWindow()
  win:move(hs.layout.left50)
  hs.grid.snap(win)
end)
k:bind({"cmd"}, "right", function()
  local win = hs.window.focusedWindow()
  win:move(hs.layout.right50)
  hs.grid.snap(win)
end)

k:bind({}, 'escape', function() k:exit() end)

-- URL Dispatcher
hs.loadSpoon("URLDispatcher")
local Zoom = "us.zoom.xos"
local Chrome = "com.google.Chrome"
spoon.URLDispatcher.url_patterns = {
  {"https?://zoom.us/j/", Zoom},
  {"https?://%w+.zoom.us/j/", Zoom}
}
spoon.URLDispatcher.default_handler = Chrome
spoon.URLDispatcher:start()
