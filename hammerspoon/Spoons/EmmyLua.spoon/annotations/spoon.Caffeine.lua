--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Prevent the screen from going to sleep
-- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/Caffeine.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/Caffeine.spoon.zip)
---@class spoon.Caffeine
local M = {}
spoon.Caffeine = M

-- Binds hotkeys for Caffeine
--
-- Parameters:
--  * mapping - A table containing hotkey modifier/key details for the following items:
--   * toggle - This will toggle the state of display sleep prevention, and update the menubar graphic
--
-- Returns:
--  * The Caffeine object
function M:bindHotkeys(mapping, ...) end

-- Sets whether or not caffeination should be enabled
--
-- Parameters:
--  * on - A boolean, true if screens should be kept awake, false to let macOS send them to sleep
--
-- Returns:
--  * None
function M:setState(on) end

-- Starts Caffeine
--
-- Parameters:
--  * None
--
-- Returns:
--  * The Caffeine object
function M:start() end

-- Stops Caffeine
--
-- Parameters:
--  * None
--
-- Returns:
--  * The Caffeine object
function M:stop() end

