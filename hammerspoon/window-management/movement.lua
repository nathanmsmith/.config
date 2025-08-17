local WindowManager = require("window-management/helpers")

-- Center
hs.hotkey.bind({ "ctrl", "alt" }, "c", function()
  local window = hs.window.focusedWindow()
  window:centerOnScreen(nil, true)
end)

hs.hotkey.bind({ "ctrl", "alt" }, "h", function()
  WindowManager.startMoving("left")
end, function()
  WindowManager.stopMoving()
end)
hs.hotkey.bind({ "ctrl", "alt" }, "j", function()
  WindowManager.startMoving("down")
end, function()
  WindowManager.stopMoving()
end)
hs.hotkey.bind({ "ctrl", "alt" }, "k", function()
  WindowManager.startMoving("up")
end, function()
  WindowManager.stopMoving()
end)
hs.hotkey.bind({ "ctrl", "alt" }, "l", function()
  WindowManager.startMoving("right")
end, function()
  WindowManager.stopMoving()
end)

local function snapWindow(direction)
  local win = hs.window.focusedWindow()
  if not win then
    return
  end

  local screen = win:screen()
  local frame = screen:frame()

  if direction == "left" then
    win:setFrame({
      x = frame.x,
      y = frame.y,
      w = frame.w / 2,
      h = frame.h,
    })
  elseif direction == "right" then
    win:setFrame({
      x = frame.x + frame.w / 2,
      y = frame.y,
      w = frame.w / 2,
      h = frame.h,
    })
  elseif direction == "up" then
    win:setFrame({
      x = frame.x,
      y = frame.y,
      w = frame.w,
      h = frame.h / 2,
    })
  elseif direction == "down" then
    win:setFrame({
      x = frame.x,
      y = frame.y + frame.h / 2,
      w = frame.w,
      h = frame.h / 2,
    })
  end
end

-- Bind keys
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "h", function()
  snapWindow("left")
end)
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "j", function()
  snapWindow("down")
end)
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "k", function()
  snapWindow("up")
end)
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "l", function()
  snapWindow("right")
end)
