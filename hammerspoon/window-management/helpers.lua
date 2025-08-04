-- WindowManager.lua
-- A Hammerspoon module for window movement and resizing

local WindowManager = {}

-- Private variables to track key state and timer
local moveTimer = nil
local currentDirection = nil

local moveAmount = 20
local resizeAmount = 20

-- Private function to move or resize window
local function moveWindow(direction)
  local win = hs.window.focusedWindow()
  if not win then
    return false
  end

  local f = win:frame()

  if direction == "left" then
    f.x = f.x - moveAmount
  elseif direction == "right" then
    f.x = f.x + moveAmount
  elseif direction == "up" then
    f.y = f.y - moveAmount
  elseif direction == "down" then
    f.y = f.y + moveAmount
  elseif direction == "grow-left" then
    f.x = f.x - resizeAmount
    f.w = f.w + resizeAmount
  elseif direction == "grow-right" then
    f.w = f.w + resizeAmount
  elseif direction == "grow-up" then
    f.y = f.y - resizeAmount
    f.h = f.h + resizeAmount
  elseif direction == "grow-down" then
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
    f.x = f.x + resizeAmount / 2
    f.y = f.y + resizeAmount / 2
    f.w = f.w - resizeAmount
    f.h = f.h - resizeAmount

    -- Prevent window from becoming too small
    if f.w <= 100 or f.h <= 100 then
      return false
    end
  elseif direction == "expand" then
    f.x = f.x - resizeAmount / 2
    f.y = f.y - resizeAmount / 2
    f.w = f.w + resizeAmount
    f.h = f.h + resizeAmount
  else
    return false -- Invalid direction
  end

  win:setFrame(f)
  return true
end

-- Public function to perform a single move/resize operation
function WindowManager.move(direction)
  return moveWindow(direction)
end

-- Public function to start continuous movement
function WindowManager.startMoving(direction)
  currentDirection = direction
  moveWindow(direction) -- Move immediately

  -- Start timer for continuous movement
  moveTimer = hs.timer.doEvery(0.05, function()
    moveWindow(currentDirection)
  end)
end

-- Public function to stop movement
function WindowManager.stopMoving()
  if moveTimer then
    moveTimer:stop()
    moveTimer = nil
  end
  currentDirection = nil
end

-- Public function to check if currently moving
function WindowManager.isMoving()
  return moveTimer ~= nil
end

-- Public function to get current direction (if moving)
function WindowManager.getCurrentDirection()
  return currentDirection
end

-- Return the module
return WindowManager
