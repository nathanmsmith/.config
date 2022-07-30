--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Control Hammerspoon's dock icon
--
-- This module is based primarily on code from the previous incarnation of Mjolnir by [Steven Degutis](https://github.com/sdegutis/).
---@class hs.dockicon
local M = {}
hs.dockicon = M

-- Bounce Hammerspoon's dock icon
--
-- Parameters:
--  * indefinitely - A boolean value, true if the dock icon should bounce until the dock icon is clicked, false if the dock icon should only bounce briefly
function M.bounce(indefinitely, ...) end

-- Hide Hammerspoon's dock icon
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M.hide() end

-- Set Hammerspoon's dock icon badge
--
-- Parameters:
--  * badge - A string containing the label to place inside the dock icon badge. If the string is empty, the badge will be cleared
function M.setBadge(badge, ...) end

-- Make Hammerspoon's dock icon visible
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M.show() end

-- Determine whether Hammerspoon's dock icon is visible
--
-- Parameters:
--  * None
--
-- Returns:
--  * A boolean, true if the dock icon is visible, false if not
---@return boolean
function M.visible() end

