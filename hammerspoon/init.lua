hs.window.animationDuration = 0

hs.loadSpoon("EmmyLua")
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- ref: https://github.com/Hammerspoon/hammerspoon/issues/2930#issuecomment-899092002
-- hs.ipc.cliInstall()

-- Variable names, no they aren't garbage collected
C = require("caffeine")
P = require("paste")
F = require("focus")
W = require("window-management")

-- Handle various willSleep/didWake actions.
-- Uses functions from caffeine and bluetooth modules.
function IsModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == "function" then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

if IsModuleAvailable("stripe") then
  S = require("stripe")
end
