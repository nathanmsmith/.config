-- The docs
-- https://www.hammerspoon.org/go/

hs.window.animationDuration = 0

hs.loadSpoon("EmmyLua")
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

modules = require("helpers.modules")

-- ref: https://github.com/Hammerspoon/hammerspoon/issues/2930#issuecomment-899092002
-- hs.ipc.cliInstall()

-- Variable names, no they aren't garbage collected
C = require("caffeine")
P = require("paste")
-- U = require("urls")

-- W = require("window-management")
-- WINDOW_MANAGEMENT_SIZING = require("window-management/sizing")
-- WINDOW_MANAGEMENT_MOVEMENT = require("window-management/movement")
-- WINDOW_MANAGEMENT_FOCUS = require("window-management/focus")
-- WINDOW_MANAGEMENT_EXPOSE = require("window-management/expose")
-- CLIP = require("ibooks-clipboard")
-- CLIP.log = hs.logger.new("ibooks-clipboard", "debug")
-- CLIP.start()

-- local modules = {
--   "ibooks-clipboard",
-- }

-- hsm = {}

-- -- global log
-- hsm.log = hs.logger.new(hs.host.localizedName(), LOGLEVEL)

-- -- load a module from modules/ dir, and set up a logger for it
-- local function loadModuleByName(modName)
--   hsm[modName] = require("modules." .. modName)
--   hsm[modName].name = modName
--   hsm[modName].log = hs.logger.new(modName, LOGLEVEL)
--   hsm.log.i(hsm[modName].name .. ": module loaded")
-- end

-- -- start a module
-- local function startModule(mod)
--   if mod.start == nil then
--     return
--   end
--   mod.start()
--   hsm.log.i(mod.name .. ": module started")
-- end

if modules.isModuleAvailable("stripe") then
  S = require("stripe")
end
