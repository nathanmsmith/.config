-- Variables to track key state and timer
local moveTimer = nil
local currentDirection = nil

-- Function to move or resize window
local function moveWindow(direction)
  local win = hs.window.focusedWindow()
  if not win then
    return
  end

  local f = win:frame()
  local resizeAmount = 10

  if direction == "h" then
    f.x = f.x - 10
  elseif direction == "l" then
    f.x = f.x + 10
  elseif direction == "k" then
    f.y = f.y - 10
  elseif direction == "j" then
    f.y = f.y + 10
  elseif direction == "resize-left" then
    f.x = f.x - resizeAmount
    f.w = f.w + resizeAmount
  elseif direction == "resize-right" then
    f.w = f.w + resizeAmount
  elseif direction == "resize-up" then
    f.y = f.y - resizeAmount
    f.h = f.h + resizeAmount
  elseif direction == "resize-down" then
    f.h = f.h + resizeAmount
  elseif direction == "shrink-left" then
    f.x = f.x + resizeAmount
    f.w = f.w - resizeAmount
  elseif direction == "shrink-right" then
    f.w = f.w - resizeAmount
  elseif direction == "shrink-up" then
    f.y = f.y + resizeAmount
    f.h = f.h - resizeAmount
  elseif direction == "shrink-down" then
    f.h = f.h - resizeAmount
  elseif direction == "shrink" then
    local shrinkAmount = 5
    f.x = f.x + shrinkAmount / 2
    f.y = f.y + shrinkAmount / 2
    f.w = f.w - shrinkAmount
    f.h = f.h - shrinkAmount

    -- Prevent window from becoming too small
    if f.w <= 100 or f.h <= 100 then
      return
    end
  elseif direction == "expand" then
    local expandAmount = 5
    f.x = f.x - expandAmount / 2
    f.y = f.y - expandAmount / 2
    f.w = f.w + expandAmount
    f.h = f.h + expandAmount
  end

  win:setFrame(f)
end

-- Function to start continuous movement
local function startMoving(direction)
  currentDirection = direction
  moveWindow(direction) -- Move immediately

  -- Start timer for continuous movement
  moveTimer = hs.timer.doEvery(0.05, function()
    moveWindow(currentDirection)
  end)
end

-- Function to stop movement
local function stopMoving()
  if moveTimer then
    moveTimer:stop()
    moveTimer = nil
  end
  currentDirection = nil
end

-- Bind keys with keyDown and keyUp events
hs.hotkey.bind({ "cmd", "alt" }, "h", function()
  startMoving("h")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt" }, "l", function()
  startMoving("l")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt" }, "k", function()
  startMoving("k")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt" }, "j", function()
  startMoving("j")
end, function()
  stopMoving()
end)

-- Resize bindings
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "h", function()
  startMoving("resize-left")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "l", function()
  startMoving("resize-right")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "k", function()
  startMoving("resize-up")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "j", function()
  startMoving("resize-down")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "h", function()
  startMoving("shrink-left")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "l", function()
  startMoving("shrink-right")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "k", function()
  startMoving("shrink-up")
end, function()
  stopMoving()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "j", function()
  startMoving("shrink-down")
end, function()
  stopMoving()
end)


-- Shrink window on all sides (hold to continuously shrink)
hs.hotkey.bind({ "cmd", "alt" }, "-", function()
  startMoving("shrink")
end, function()
  stopMoving()
end)

-- Expand window on all sides (hold to continuously expand)
hs.hotkey.bind({ "cmd", "alt" }, "=", function()
  startMoving("expand")
end, function()
  stopMoving()
end)

-- Center
hs.hotkey.bind({ "alt" }, "c", function()
  local window = hs.window.focusedWindow()
  window:centerOnScreen(nil, true)
end)

-- Fullscreen
hs.hotkey.bind({ "alt" }, "f", function()
  local window = hs.window.focusedWindow()
  window:maximize(true)
end)
