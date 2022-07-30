--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- A much-needed eject menu for your Mac menu bar. Allows ejecting
-- individual or all non-internal disks. Ejection can also be
-- triggered on sleep, on lid close, or using a hotkey.
--
-- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/EjectMenu.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/EjectMenu.spoon.zip)
---@class spoon.EjectMenu
local M = {}
spoon.EjectMenu = M

-- Binds hotkeys for EjectMenu
--
-- Parameters:
--  * mapping - A table containing hotkey objifier/key details for the following items:
--   * ejectAll - eject all volumes.
function M:bindHotkeys(mapping, ...) end

-- Boolean, whether to eject volumes when the laptop lid is closed
-- with an external display connected. There is no "lid close" event,
-- so we detect when the internal display gets disabled. This method
-- is somewhat unreliable (e.g. it also triggers when the internal
-- display goes to sleep due to inactivity), so its default value is
-- `false`
M.eject_on_lid_close = nil

-- Boolean, whether to eject volumes before the system goes to sleep. Default value: true
M.eject_on_sleep = nil

-- Eject all volumes
--
-- Parameters
--  * persistent_notifs: a boolean indicating whether notifications (if shown) should be persistent.
function M:ejectVolumes() end

-- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
M.logger = nil

-- List containing volume paths that should never be ejected. Default value: empty list
M.never_eject = nil

-- Boolean, whether to produce a notification about the volumes that get ejected. Default value: `false`
M.notify = nil

-- List of additional system events on which the volumes should be ejected. The
-- values must be
-- [http://www.hammerspoon.org/docs/hs.caffeinate.watcher.html](`hs.caffeinate.watcher`)
-- constant values. Default value: empty list
M.other_eject_events = nil

-- Determine if a volume should be ejected.
--
-- Parameters:
--  * path - the mount path of the volume.
--  * info - a table containing a data structure as returned by `hs.fs.volume.allVolumes()`.
-- Returns:
--  * A boolean indicating whether the volume should be ejected.
function M:shouldEject(path, info, ...) end

-- Boolean, whether to show a menubar button to eject all drives. Default value: true
M.show_in_menubar = nil

-- Start the watchers for power events and screen changes, to trigger volume ejection.
function M:start() end

-- Stop the watchers
function M:stop() end

-- Return table of volumes to be ejected when "Eject All" is invoked.
--
-- Returns:
--  * A table in the same format as returned by
--    `hs.fs.volume.allVolumes()` but containing only those volumes
--    for which `EjectMenu:shouldEject()` returns `true`.
--  * An integer indicating how many volumes are in the table.
function M:volumesToEject() end

